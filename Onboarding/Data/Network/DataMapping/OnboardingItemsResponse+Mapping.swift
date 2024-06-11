//
//  OnboardingItems+Mapping.swift
//  Onboarding
//
//  Created by Dmytro Hetman on 07.06.2024.
//

import Foundation

struct OnboardingModel: Decodable {
    let items: [OnboardingItemSetup]
}

struct OnboardingItemSetup: Decodable {
    let id: Int
    let question: String
    let answers: [String]
}
