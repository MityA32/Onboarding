//
//  OnboardingScreensViewModel.swift
//  Onboarding
//
//  Created by Dmytro Hetman on 06.06.2024.
//

import Foundation
import RxSwift
import RxRelay

enum OnboardingPageType {
    case question
    case subscription
}

struct OnboardingPageSetup {
    let id: Int
    let type: OnboardingPageType
    let item: OnboardingItem?
    
    init(id: Int, _ type: OnboardingPageType, _ item: OnboardingItem? = nil) {
        self.id = id
        self.type = type
        self.item = item
    }
}

final class OnboardingScreensViewModel {

    let inNewPageClick = PublishSubject<Void>()
    let inCloseClick = PublishSubject<Void>()
    let inRestorePurchaseClick = PublishSubject<Void>()
    let manageOnboarding = PublishSubject<OnboardingEvent>()
    let currentPage: BehaviorRelay<OnboardingPageSetup>
    let optionSelected = BehaviorRelay(value: false)
    

    let disposeBag = DisposeBag()

    var onboardingPages: [OnboardingPageSetup] = []

    private let subscriptionService: SubscriptionServiceProtocol
    
    init(subscriptionService: SubscriptionServiceProtocol, pages: [OnboardingPageSetup]) {
        self.subscriptionService = subscriptionService
        let firstPage = pages.first ?? OnboardingPageSetup(id: 1, .subscription)
        self.currentPage = BehaviorRelay<OnboardingPageSetup>(value: firstPage)
        onboardingPages = pages
        setupRx()
    }
    
    private func setupRx() {
        inNewPageClick
            .withLatestFrom(currentPage)
            .map { [weak self] page -> OnboardingPageSetup? in
                print("hello")
                guard let self else { return nil }
                let nextPageIndex = currentPage.value.id + 1
                guard nextPageIndex - 1 < self.onboardingPages.count else { return nil }
                return self.onboardingPages[nextPageIndex - 1]
            }
            .compactMap { $0 }
            .bind(to: currentPage)
            .disposed(by: disposeBag)
        
        let processPaymentObservable = inNewPageClick
            .withLatestFrom(currentPage)
            .filter { [weak self] in $0.id == (self?.onboardingPages.count ?? -1)}
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

