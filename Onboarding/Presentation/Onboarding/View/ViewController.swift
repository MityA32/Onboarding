//
//  ViewController.swift
//  Onboarding
//
//  Created by Dmytro Hetman on 06.06.2024.
//

import UIKit

class ViewController: UIViewController {

    var viewModel: OnboardingScreensViewModel? {
        didSet {
            setup()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    private func setup() {
        
    }
    
    private func setupBackground() {
        view.backgroundColor = .hexF1F1F5
    }


}

