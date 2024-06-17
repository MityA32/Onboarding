import UIKit
import RxSwift
import RxCocoa

final class AppCoordinator: Coordinator {
    private var window: UIWindow
    let navigationController = UINavigationController()
    
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
                    manageOnboarding(for: pages)
                    
                case .failure(let error):
                    showErrorAlert(with: error.localizedDescription)
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

                    var onboardingPages = onboardingPages(from: onboarding)
                    
                    if let lastItem = onboardingPages.last {
                        onboardingPages.append(OnboardingPageSetup(id: lastItem.id + 1, .subscription))
                    }
                    completion(.success(onboardingPages))
                case .error(_):
                    completion(.success([OnboardingPageSetup(id: 1, .subscription)]))
                }
            }
        } catch {
            completion(.success([OnboardingPageSetup(id: 1, .subscription)]))
        }
    }
    
    private func manageOnboarding(for pages: [OnboardingPageSetup]) {
        DispatchQueue.main.async { [weak self] in
            let onboardingViewModel = OnboardingScreensViewModel(
                subscriptionService: InAppPurchaseService(), pages: pages)
            let onboardingViewController = OnboardingViewController(viewModel: onboardingViewModel)
            
            onboardingViewModel.manageOnboarding
                .observe(on: MainScheduler.instance)
                .bind { [weak self] action in
                    switch action {
                    case .pop:
                        self?.navigationController.viewControllers = []
                        print("Close Onboarding")
                    case .push:
                        print("Push to next")
                    case .paymentFailed(let error):
                        self?.showErrorAlert(with: error.title)
                    }
                }
                .disposed(by: onboardingViewModel.disposeBag)
            
            self?.navigationController.viewControllers = [onboardingViewController]
        }
    }
    
    private func showErrorAlert(with errorMessage: String) {
        let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        DispatchQueue.main.async { [weak self] in
            self?.navigationController.present(alert, animated: true)
        }
    }
    
    private func onboardingPages(from model: OnboardingModel) -> [OnboardingPageSetup] {
        model.items
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
    }
}
