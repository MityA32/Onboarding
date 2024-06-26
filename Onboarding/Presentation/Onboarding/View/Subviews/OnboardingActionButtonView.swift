//
//  OnboardingActionButtonView.swift
//  Onboarding
//
//  Created by Dmytro Hetman on 09.06.2024.
//

import UIKit

final class OnboardingActionButton: UIButton {
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        layer.cornerRadius = 28
        layer.shadowColor = UIColor.hex80808025.cgColor
        layer.shadowOpacity = 1.0
        layer.shadowOffset = CGSize(width: 0, height: -4)
        layer.shadowRadius = 36
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
    }

    
    private func setup() {
        setupViews()
    }
    
    private func setupViews() {
        clipsToBounds = false
    }
    
    func setupAppearence(type: OnboardingPageType, isTapable: Bool = false) {
        
        
        switch type {
            case .question:
                isUserInteractionEnabled = isTapable
                setTitle("Continue", for: .normal)
                setTitleColor(isTapable ? .hexFFFFFF : .hexCACACA, for: .normal)
                layer.backgroundColor = isTapable ? UIColor.hex101B18.cgColor : UIColor.hexFFFFFF.cgColor
            case .subscription:
                isUserInteractionEnabled = true
                setTitle("Start Now", for: .normal)
                setTitleColor(.hexFFFFFF, for: .normal)
                layer.backgroundColor = UIColor.hex101B18.cgColor
        }
        
        titleLabel?.font = Parameters.OnboardingPage.ActionButton.font
        titleLabel?.textAlignment = .center

    }
    
}
