//
//  OnboardingActionButtonView.swift
//  Onboarding
//
//  Created by Dmytro Hetman on 09.06.2024.
//

import UIKit

final class OnboardingActionButton: UIButton {
    
    private let customTitleLabel = UILabel()
    private let background = UIView()
    
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
        setupLayout()
        setupViews()
    }
    
    private func setupLayout() {
//        addSubview(background)
//        background.snp.makeConstraints {
//            $0.edges.equalToSuperview()
//        }
//
//        addSubview(customTitleLabel)
//        customTitleLabel.snp.makeConstraints {
//            $0.centerY.equalTo(snp.centerY)
//            $0.horizontalEdges.equalTo(snp.horizontalEdges)
//            $0.height.equalTo(20)
//        }
    }
    
    private func setupViews() {
        clipsToBounds = false
    }
    
    func setupAppearence(type: OnboardingPageType, isTapable: Bool = false) {
        
   
        
        switch type {
            case .question:
                setTitle("Continue", for: .normal)
                setTitleColor(isTapable ? .hexFFFFFF : .hexCACACA, for: .normal)
                layer.backgroundColor = isTapable ? UIColor.hex101B18.cgColor : UIColor.hexFFFFFF.cgColor
            case .subscription:
                setTitle("Start Now", for: .normal)
                setTitleColor(.hexFFFFFF, for: .normal)
                layer.backgroundColor = UIColor.hex101B18.cgColor
        }
        
        titleLabel?.font = Parameters.OnboardingPage.ActionButton.font
        titleLabel?.textAlignment = .center

    }
    
}
