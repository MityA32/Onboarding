//
//  AppDelegate.swift
//  Onboarding
//
//  Created by Dmytro Hetman on 06.06.2024.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var appCoordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Initialize the window
        window = UIWindow(frame: UIScreen.main.bounds)
        
        // Initialize the app coordinator with the window
        if let window {
            appCoordinator = AppCoordinator(window: window)
            appCoordinator?.start()
        }
        
        
        return true
    }

}

