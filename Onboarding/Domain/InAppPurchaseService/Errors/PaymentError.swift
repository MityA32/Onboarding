//
//  PaymentError.swift
//  Onboarding
//
//  Created by Dmytro Hetman on 06.06.2024.
//

import Foundation

enum PaymentError: Error {
    case cantMakePayment
    case cantRestore
    case productNotFound
}

extension PaymentError {
    var title: String {
        switch self {
            case .cantMakePayment:
                return "PaymentError: Can't make payment"
            case .cantRestore:
                return "PaymentError: Can't restore"
            case .productNotFound:
                return "PaymentError: Product not found"
        }
    }
}
