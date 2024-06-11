//
//  PrivacyCenterOption.swift
//  Onboarding
//
//  Created by Dmytro Hetman on 06.06.2024.
//

import Foundation

enum PrivacyCenterOption {
    case termsOfUse
    case privacyPolicy
    case subscriptionTerms
}

extension PrivacyCenterOption {
    var title: String {
        switch self {
            case .termsOfUse:
                return "Terms of Use"
            case .privacyPolicy:
                return "Privacy Policy"
            case .subscriptionTerms:
                return "Subscription Terms"
        }
    }
    
    var link: String {
        switch self {
            case .privacyPolicy:
                return "https://doc-hosting.flycricket.io/onboardingscreens-privacy-policy/4c5e49d0-6911-46bf-bab8-ea7882ce12a9/privacy"
            case .termsOfUse, .subscriptionTerms:
                return "https://doc-hosting.flycricket.io/onboardingscreens-terms-of-use/eca5b212-9915-41a7-b04f-64dfd2ee86df/terms"
        }
    }
}
