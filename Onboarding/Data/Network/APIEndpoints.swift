//
//  APIEndpoints.swift
//  Onboarding
//
//  Created by Dmytro Hetman on 07.06.2024.
//

import Foundation

enum APIHost {
    static let universeappsLimited = "https://test-ios.universeapps.limited"
}

protocol Endpoint {
    
    var pathComponent: String { get }
    
}

enum OnboardingEndpoint: String, Endpoint {
    
    case onboardingItems = "onboarding"
    
    var pathComponent: String {
        rawValue
    }
    
}


