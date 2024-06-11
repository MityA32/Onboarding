//
//  Coordinator.swift
//  Onboarding
//
//  Created by Dmytro Hetman on 06.06.2024.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get }
    func start()
}
