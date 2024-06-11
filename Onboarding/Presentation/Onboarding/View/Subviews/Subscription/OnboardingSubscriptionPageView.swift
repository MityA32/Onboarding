//
//  OnboardingSubscriptionPageView.swift
//  Onboarding
//
//  Created by Dmytro Hetman on 08.06.2024.
//

import UIKit
import SnapKit

final class OnboardingSubscriptionPageView: UIView {
    
    private let subscriptionImage = UIImageView()
    private let titleLabel = UILabel()
    private let priceInfoLabel = UILabel()
    private let termsLabel = UITextView()
    let subscriptionManagerBarView = SubscriptionManagerBarView()
    
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        configureViews()
        setupLayout()
        setupSubscriptionManagerBarView()
    }
    
    private func configureViews() {
        
        subscriptionImage.image = .imageOnboardingSubscriptionIllustration
        subscriptionImage.contentMode = .scaleAspectFill
        
        titleLabel.attributedText = Parameters.OnboardingPage.SubscriptionItem.InfoText.title
        titleLabel.numberOfLines = 0
        
        priceInfoLabel.attributedText = Parameters.OnboardingPage.SubscriptionItem.InfoText.price
        priceInfoLabel.numberOfLines = 0
        
        termsLabel.attributedText = Parameters.OnboardingPage.SubscriptionItem.TermsLabel.attributedText
        termsLabel.textAlignment = .center
        termsLabel.delegate = self
        termsLabel.isEditable = false
        termsLabel.isScrollEnabled = false
        termsLabel.backgroundColor = .clear
        termsLabel.isSelectable = true
        termsLabel.textContainer.lineFragmentPadding = 0
        termsLabel.textContainerInset = .zero
        
    }
    
    private func setupLayout() {
        
        addSubview(subscriptionImage)
        subscriptionImage.snp.makeConstraints {
            $0.top.equalTo(snp.top)
            $0.horizontalEdges.equalTo(snp.horizontalEdges)
            $0.height.equalTo(snp.height).dividedBy(2)
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(subscriptionImage.snp.bottom).offset(40)
            $0.horizontalEdges.equalTo(snp.horizontalEdges).inset(24)
            $0.height.equalTo(72)
        }
        
        addSubview(priceInfoLabel)
        priceInfoLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.horizontalEdges.equalTo(snp.horizontalEdges).inset(24)
            $0.height.equalTo(40)
        }
        
        addSubview(termsLabel)
        termsLabel.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
            $0.horizontalEdges.equalTo(snp.horizontalEdges).inset(24)
            $0.height.equalTo(28)
        }
        
    }
    
    private func setupSubscriptionManagerBarView() {
        addSubview(subscriptionManagerBarView)
        subscriptionManagerBarView.snp.makeConstraints {
            $0.height.equalTo(44)
            $0.left.right.equalToSuperview()
            $0.top.equalTo(safeAreaLayoutGuide.snp.top)
        }
    }
    
   
}

extension OnboardingSubscriptionPageView: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool {
        UIApplication.shared.open(URL)
        return false
    }
}
