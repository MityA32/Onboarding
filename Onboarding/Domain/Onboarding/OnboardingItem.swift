//
//  OnboardingPage.swift
//  Onboarding
//
//  Created by Dmytro Hetman on 06.06.2024.
//

import Foundation

struct OnboardingItemCellModel {
    let id: Int
    let question: String
    var answers: [OnboardingTableItemCellModel]
}

struct OnboardingTableItemCellModel {
    let title: String
    var isSelected: Bool
}
