//
//  AppCoordinator.swift
//  Onboarding
//
//  Created by Dmytro Hetman on 06.06.2024.
//

import UIKit
import RxSwift
import RxCocoa

final class AppCoordinator: Coordinator {
    private var window = UIWindow(frame: UIScreen.main.bounds)
    var navigationController = UINavigationController()
    
    private let disposeBag = DisposeBag()
    
    init() {
        navigationController.navigationBar.isHidden = true
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func start() {
        showOnboarding()
    }
    
    private func showOnboarding() {

        do {
            let networkService = try Network<OnboardingEndpoint>(APIHost.universeappsLimited)
            let onboardingViewModel = OnboardingScreensViewModel(
                subscriptionService: InAppPurchaseService(),
                networkService: networkService)
            let onboardingViewController = ViewController()
            onboardingViewController.viewModel = onboardingViewModel
            
            onboardingViewModel.manageOnboarding
                .bind { [weak self] in
                    switch $0 {
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
            
            navigationController.viewControllers = [onboardingViewController]
        } catch {
            print(error)
        }

    }
    
}
