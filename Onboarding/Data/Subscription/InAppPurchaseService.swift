//
//  InAppPurchaseService.swift
//  Onboarding
//
//  Created by Dmytro Hetman on 06.06.2024.
//

import Foundation
import StoreKit
import RxSwift

final class InAppPurchaseService: NSObject, SubscriptionServiceProtocol {
    static let productIdentifier = "com.hetmanProduct.subscription.monthly"
    
    private let outPaymentResult = PublishSubject<Result<Void, PaymentError>>()

    var outPaymentResultObservable: Observable<Result<Void, PaymentError>> {
        outPaymentResult.asObservable()
    }
    
    private var products: [Product] = []
    
    override init() {
        super.init()

        Task {
            await loadProducts()
        }
    }
    
    func loadProducts() async {
        do {
            self.products = try await Product.products(for: [InAppPurchaseService.productIdentifier])
                .sorted(by: { $0.price > $1.price })
        } catch {
            print("Failed to fetch products!")
        }
    }
    
    func processPayment() -> Single<Result<Void, PaymentError>> {
        Single.create { [weak self] single in
            Task { [weak self] in
                if let product = self?.products.first(where: { $0.id == InAppPurchaseService.productIdentifier }) {
                    let result = try await product.purchase()
                    
                    switch result {
                    case .success(let verification):
                        switch verification {
                        case .unverified:
                            single(.success(.failure(PaymentError.purchaseFailed)))
                        case .verified:
                            single(.success(.success(())))
                        }
                    case .pending:
                        single(.success(.failure(PaymentError.purchasePending)))
                    case .userCancelled:
                        single(.success(.failure(PaymentError.userCancelled)))
                    @unknown default:
                        single(.success(.failure(PaymentError.unknown)))
                    }
                } else {
                    single(.success(.failure(PaymentError.productNotFound)))
                    self?.outPaymentResult.onNext(.failure(PaymentError.productNotFound))
                }
            }
            
            return Disposables.create()
        }
    }

}
