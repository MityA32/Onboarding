//
//  OnboardingPageView.swift
//  Onboarding
//
//  Created by Dmytro Hetman on 06.06.2024.
//

import UIKit

final class OnboardingPageView: UIView {
    
    let subscriptionPageView = OnboardingSubscriptionPageView()
    let itemsPageView = OnboardingItemPageView()
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        subscriptionPageView.transform = CGAffineTransform(translationX: frame.width, y: 0)
    }
    
    private func setup() {
        setupLayout()
    }
    
    private func setupLayout() {
        addSubview(itemsPageView)
        itemsPageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        addSubview(subscriptionPageView)
        subscriptionPageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        subscriptionPageView.transform = CGAffineTransform(translationX: frame.width, y: 0)
    }
    
    func showSubscription() {
        UIView.animate(withDuration: 0.5, 
                       delay: 0,
                       options: [],
                       animations: { [weak self] in
                            guard let self else { return }
                            subscriptionPageView.transform = .identity
                            itemsPageView.transform = CGAffineTransform(translationX: -frame.width, y: 0)
                        },
                       completion: nil
        )
    }
}
