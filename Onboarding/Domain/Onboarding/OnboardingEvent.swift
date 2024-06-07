//
//  OnboardingEvent.swift
//  Onboarding
//
//  Created by Dmytro Hetman on 06.06.2024.
//

import Foundation

enum OnboardingEvent {
    case pop
    case push
    case paymentFailed(error: PaymentError)
}
