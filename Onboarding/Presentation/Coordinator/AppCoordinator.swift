import UIKit
import RxSwift
import RxCocoa

final class AppCoordinator: Coordinator {
    private var window: UIWindow
    var navigationController = UINavigationController()
    
    private let disposeBag = DisposeBag()
    
    init(window: UIWindow) {
        self.window = window
        navigationController.navigationBar.isHidden = true
        self.window.rootViewController = navigationController
        self.window.makeKeyAndVisible()
    }
    
    func start() {
        showOnboarding()
    }
    
    private func showOnboarding() {
        configureOnboarding { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let pages):
                DispatchQueue.main.async { [weak self] in
                    let onboardingViewModel = OnboardingScreensViewModel(
                        subscriptionService: InAppPurchaseService(), pages: pages)
                    let onboardingViewController = OnboardingViewController()
                    onboardingViewController.viewModel = onboardingViewModel
                    
                    onboardingViewModel.manageOnboarding
                        .observe(on: MainScheduler.instance)
                        .bind { action in
                            switch action {
                            case .pop:
                                self?.navigationController.viewControllers = []
                                print("Close Onboarding")
                            case .push:
                                print("Push to next")
                            case .paymentFailed(let error):
                                let paymentFailedAlert = UIAlertController(title: "Error", message: error.title, preferredStyle: .alert)
                                let okAction = UIAlertAction(title: "OK", style: .default)
                                paymentFailedAlert.addAction(okAction)
                                self?.navigationController.present(paymentFailedAlert, animated: true)
                                print("Payment failed")
                            }
                        }
                        .disposed(by: onboardingViewModel.disposeBag)
                    
                    self?.navigationController.viewControllers = [onboardingViewController]
                }
                
            case .failure(let error):
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default)
                alert.addAction(okAction)
                DispatchQueue.main.async { [weak self] in
                    self?.navigationController.present(alert, animated: true)
                }
            }
        }
    }
    
    private func configureOnboarding(completion: @escaping (Result<[OnboardingPageSetup], Error>) -> Void) {
        do {
            let networkService = try Network<OnboardingEndpoint>(APIHost.universeappsLimited)
            networkService.perform(.get, .onboardingItems) { [weak self] result in
                guard let self else { return }
                switch result {
                case .data(let data):
                    guard let data,
                          let onboarding = try? JSONDecoder().decode(OnboardingModel.self, from: data) else {
                        completion(.failure(NetworkError.decodingFailed))
                        return
                    }

                    var onboardingPages = onboarding.items
                        .map { OnboardingPageSetup(
                            id: $0.id,
                            .question,
                            .init(
                                id: $0.id,
                                question: $0.question,
                                answers: $0.answers
                                    .map { .init(title: $0, isSelected: false) }
                            )
                        )}
                    
                    if let lastItem = onboardingPages.last {
                        onboardingPages.append(OnboardingPageSetup(id: lastItem.id + 1, .subscription))
                    }
                    completion(.success(onboardingPages))
                case .error(let failure):
                    completion(.success([OnboardingPageSetup(id: 1, .subscription)]))
                }
            }
        } catch {
            completion(.success([OnboardingPageSetup(id: 1, .subscription)]))
        }
    }
}

enum NetworkError: Error {
    case decodingFailed
}
