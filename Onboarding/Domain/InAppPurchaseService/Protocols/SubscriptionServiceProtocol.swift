//
//  SubscriptionServiceProtocol.swift
//  Onboarding
//
//  Created by Dmytro Hetman on 06.06.2024.
//

import RxSwift

protocol SubscriptionServiceProtocol {
    var outPaymentResultObservable: Observable<Result<Void, PaymentError>> { get }
    var outRestoreResultObservable: Observable<Result<Void, PaymentError>> { get }
    func processPayment() -> Single<Result<Void, PaymentError>>
    func restorePayment() -> Observable<Result<Void, PaymentError>>
}
