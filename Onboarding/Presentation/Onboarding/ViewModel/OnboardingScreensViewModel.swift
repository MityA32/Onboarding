//
//  OnboardingScreensViewModel.swift
//  Onboarding
//
//  Created by Dmytro Hetman on 06.06.2024.
//

import Foundation
import RxSwift
import RxRelay

final class OnboardingScreensViewModel {

    let inNewPageClick = PublishSubject<Void>()
    let inCloseClick = PublishSubject<Void>()
    let inRestorePurchaseClick = PublishSubject<Void>()
    let manageOnboarding = PublishSubject<OnboardingEvent>()
    let currentPage = BehaviorRelay<OnboardingItem?>(value: nil)

    let disposeBag = DisposeBag()

    lazy var pages: [OnboardingItem] = []

    private let subscriptionService: SubscriptionServiceProtocol
    private let networkService: Network<OnboardingEndpoint>
    
    init(subscriptionService: SubscriptionServiceProtocol, networkService: Network<OnboardingEndpoint>) {
        self.subscriptionService = subscriptionService
        self.networkService = networkService
        setupRx()
    }
    
    private func setupRx() {
        inNewPageClick
            .withLatestFrom(currentPage)
            .filter { [weak self] in $0?.id ?? 0 < (self?.pages.count ?? 0) - 1 }
            .map { [weak self] page -> OnboardingItem? in
                guard let self, let page else { return nil }
                return self.pages[page.id + 1]
            }
            .bind(to: currentPage)
            .disposed(by: disposeBag)
        
        let processPaymentObservable = inNewPageClick
            .withLatestFrom(currentPage)
            .filter { $0?.id ?? 0 == 3 }
            .skip(1)
            .flatMap { [weak self] _ -> Single<Result<Void, PaymentError>> in
               self?.subscriptionService.processPayment() ?? .error(PaymentError.cantMakePayment)
            }
            .catchAndReturn(.failure(.productNotFound))
            .flatMapLatest { [weak self] event in
                self?.subscriptionService.outPaymentResultObservable ?? .empty()
            }
        let restorePurchaseObservable = inRestorePurchaseClick
            .flatMap { [weak self] _ in
                self?.subscriptionService.restorePayment() ?? .empty()
            }
            .flatMapLatest { [weak self] res in
                self?.subscriptionService.outRestoreResultObservable ?? .empty()
            }
        
        Observable
            .merge(processPaymentObservable, restorePurchaseObservable)
            .map {
                switch $0 {
                    case .success(_):
                        return .pop
                    case .failure(let error):
                        return .paymentFailed(error: error)
                }
            }
            .bind(to: manageOnboarding)
            .disposed(by: disposeBag)
        
        inCloseClick
            .map { _ in .pop }
            .bind(to: manageOnboarding)
            .disposed(by: disposeBag)
        
    }
}

