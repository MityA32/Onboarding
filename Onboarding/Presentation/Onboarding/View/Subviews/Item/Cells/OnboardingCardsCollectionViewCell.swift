//
//  OnboardingCardsCollectionViewCell.swift
//  Onboarding
//
//  Created by Dmytro Hetman on 09.06.2024.
//

import UIKit

final class OnboardingCardsCollectionViewCell: UICollectionViewCell {
    
    static let id = "\(OnboardingCardsCollectionViewCell.self)"
    
    private let questionLabel = UILabel()
    private let optionsTableView = UITableView()
    
    func configureCell(_ item: OnboardingItem?) {
        guard let item else { return }
        questionLabel.text = item.question
        questionLabel.font = CustomFont.sfUIText(ofSize: 20, weight: .semibold)
        questionLabel.textColor = .hex1A1A1A
        
        contentView.addSubview(questionLabel)
        questionLabel.snp.makeConstraints {
            $0.height.equalTo(24)
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(0)
        }
        
        contentView.addSubview(optionsTableView)
        optionsTableView.snp.makeConstraints {
            $0.top.equalTo(questionLabel.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(0)
            $0.bottom.equalToSuperview()
        }
    }
    
}
