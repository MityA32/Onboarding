//
//  OnboardingItemPageView.swift
//  Onboarding
//
//  Created by Dmytro Hetman on 08.06.2024.
//

import UIKit

final class OnboardingItemPageView: UIView {
    
    private let titleLabel = UILabel()
    let onboardingItemsCollectionView: UICollectionView = {
        let carouselLayout = UICollectionViewFlowLayout()
        carouselLayout.scrollDirection = .horizontal
        carouselLayout.sectionInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        return UICollectionView(frame: .zero, collectionViewLayout: carouselLayout)
    }()
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        setupTitleLabel()
        setupOnboardingCardsCollectionView()
    }
    
    private func setupTitleLabel() {
        titleLabel.attributedText = Parameters.OnboardingPage.OnboardingItem.MainText.title
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(60)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(30)
        }
    }
    
    private func setupOnboardingCardsCollectionView() {
        
        onboardingItemsCollectionView.isScrollEnabled = false
        onboardingItemsCollectionView.backgroundColor = .clear
        onboardingItemsCollectionView.showsHorizontalScrollIndicator = false
        onboardingItemsCollectionView.register(
            OnboardingCardsCollectionViewCell.self,
            forCellWithReuseIdentifier: OnboardingCardsCollectionViewCell.id)
        
        addSubview(onboardingItemsCollectionView)
        onboardingItemsCollectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(32)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
        
    }
    
}
