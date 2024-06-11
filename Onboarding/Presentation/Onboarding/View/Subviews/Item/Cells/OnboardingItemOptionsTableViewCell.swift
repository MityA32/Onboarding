//
//  OnboardingItemOptionsTableViewCell.swift
//  Onboarding
//
//  Created by Dmytro Hetman on 10.06.2024.
//

import UIKit

final class OnboardingItemOptionsTableViewCell: UITableViewCell {
    
    static let id = "\(OnboardingItemOptionsTableViewCell.self)"
    
    let background = UIView()
    let titleLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0))
        background.layer.cornerRadius = 16
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = ""
    }
    
    func configureCell(_ element: OnboardingTableItemCellModel) {
        selectionStyle = .none
        
        titleLabel.text = element.title
        titleLabel.font = CustomFont.sfProDisplay(ofSize: 16, weight: .medium)
        titleLabel.textColor = .hex1A1A1A
        
        backgroundColor = .clear
        
        
        addSubview(background)
        background.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 0, bottom: 12, right: 0))
        }
        
        background.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }
        
        setSelection(element.isSelected)
    }
    
    func setSelection(_ isSelected: Bool) {
        titleLabel.textColor = isSelected ? .hexFFFFFF : .hex1A1A1A
        background.layer.backgroundColor = isSelected ? UIColor.hex47BE9A.cgColor : UIColor.hexFFFFFF.cgColor
    }
    
}
