//
//  AppCoordinator.swift
//  Onboarding
//
//  Created by Dmytro Hetman on 06.06.2024.
//

import UIKit
import RxSwift

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
        
    }
    
}

