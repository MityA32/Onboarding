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
    var item: OnboardingItemCellModel?
    
    init(id: Int, _ type: OnboardingPageType, _ item: OnboardingItemCellModel? = nil) {
        self.id = id
        self.type = type
        self.item = item
    }
}

final class OnboardingScreensViewModel {

    let inNewPageClick = PublishSubject<Void>()
    let inCloseClick = PublishSubject<Void>()
    let manageOnboarding = PublishSubject<OnboardingEvent>()
    let currentPage: BehaviorRelay<OnboardingPageSetup>
    let inOptionSelected = BehaviorRelay<IndexPath?>(value: nil)
    let outCurrentOptionSelected = BehaviorRelay<IndexPath?>(value: nil)
    

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
            .compactMap { [weak self] page -> OnboardingPageSetup? in
                guard let self else { return nil }
                let nextPageIndex = currentPage.value.id + 1
                guard nextPageIndex - 1 < self.onboardingPages.count else { return nil }
                return self.onboardingPages[nextPageIndex - 1]
            }
            .bind(to: currentPage)
            .disposed(by: disposeBag)
        
        inOptionSelected
            .compactMap { [weak self] selectedOption -> IndexPath? in
                guard let self, let selectedOption else { return nil }

                let currentIndex = self.currentPage.value.id - 1
                guard currentIndex < self.onboardingPages.count else { return nil }

                guard let currentItem = self.onboardingPages[currentIndex].item else { return nil }

                if currentItem.answers[selectedOption.row].isSelected {

                    self.onboardingPages[currentIndex].item?.answers[selectedOption.row].isSelected = false
                } else {
                    for (index, _) in currentItem.answers.enumerated() {
                        self.onboardingPages[currentIndex].item?.answers[index].isSelected = false
                    }

                    self.onboardingPages[currentIndex].item?.answers[selectedOption.row].isSelected = true
                }


                return selectedOption
            }
            .bind(to: outCurrentOptionSelected)
            .disposed(by: disposeBag)

        inNewPageClick
            .withLatestFrom(currentPage)
            .filter { [weak self] in $0.id == (self?.onboardingPages.count ?? -1)}
            .skip(1)
            .flatMap { [weak self] _ -> Single<Result<Void, PaymentError>> in
               self?.subscriptionService.processPayment() ?? .error(PaymentError.cantMakePayment)
            }
            .catchAndReturn(.failure(.productNotFound))
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

