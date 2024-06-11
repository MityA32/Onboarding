//
//  PaymentError.swift
//  Onboarding
//
//  Created by Dmytro Hetman on 06.06.2024.
//

import Foundation

enum PaymentError: Error {
    case cantMakePayment
    case productNotFound
    case purchaseFailed
    case purchasePending
    case userCancelled
    case unknown
}

extension PaymentError {
    var title: String {
        switch self {
            case .cantMakePayment:
                return "PaymentError: Can't make payment"
            case .productNotFound:
                return "PaymentError: Product not found"
            case .purchaseFailed:
                return "PaymentError: Purchase failed"
            case .purchasePending:
                return "PaymentError: Purchase pending"
            case .userCancelled:
                return "PaymentError: User cancelled"
            case .unknown:
                return "PaymentError: unknown"
        }
    }
}
