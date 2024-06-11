//
//  OnboardingCardsCollectionViewCell.swift
//  Onboarding
//
//  Created by Dmytro Hetman on 09.06.2024.
//

import UIKit
import RxSwift

final class OnboardingCardsCollectionViewCell: UICollectionViewCell {
    
    static let id = "\(OnboardingCardsCollectionViewCell.self)"
    
    private let questionLabel = UILabel()
    let optionsTableView = UITableView()
    
    let inOptionSelected = BehaviorSubject<IndexPath?>(value: nil)
    var disposeBag = DisposeBag()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.questionLabel.text = ""
        self.disposeBag = .init()
    }
    
    func configureCell(_ item: OnboardingItemCellModel?) {
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
        optionsTableView.backgroundColor = .clear
        optionsTableView.separatorStyle = .none
        optionsTableView.rowHeight = 64
        
        optionsTableView.register(OnboardingItemOptionsTableViewCell.self, forCellReuseIdentifier: OnboardingItemOptionsTableViewCell.id)
        
        
        
        Observable.just(item.answers)
            .bind(to: optionsTableView.rx.items(cellIdentifier: OnboardingItemOptionsTableViewCell.id, cellType: OnboardingItemOptionsTableViewCell.self)) { (row, element, cell) in
                cell.configureCell(element)
            }
            .disposed(by: disposeBag)
        
        optionsTableView.rx.itemSelected
//            .map { answers[$0.row] }
            .bind(to: inOptionSelected)
            .disposed(by: disposeBag)
        
    }
    
}
