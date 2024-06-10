//
//  SubscriptionManagerBarView.swift
//  Onboarding
//
//  Created by Dmytro Hetman on 08.06.2024.
//

import UIKit
import SnapKit
import RxSwift

final class SubscriptionManagerBarView: UIView {
    
    private let restorePurchaseButtonView = UIButton()
    private let closeScreenButton = UIButton()
    
    let inRestorePurchaseClick = PublishSubject<Void>()
    let inCloseClick = PublishSubject<Void>()
    let disposeBag = DisposeBag()
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        setupViews()
    }
    
    private func setupViews() {
        setupCancelIcon()
    }
    
    private func setupCancelIcon() {
        closeScreenButton.setImage(Parameters.OnboardingPage.SubscriptionItem.ManagerBarView.cancelIcon, for: .normal)
        
        closeScreenButton.contentMode = .scaleAspectFit
        
        closeScreenButton.rx.tap
            .bind(to: inCloseClick)
            .disposed(by: disposeBag)
        
        addSubview(closeScreenButton)
        closeScreenButton.snp.makeConstraints {
            $0.width.height.equalTo(24)
            $0.right.equalTo(-16)
            $0.centerY.equalTo(snp.centerY)
        }
    }
    
}
