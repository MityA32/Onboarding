//
//  EndpointsInstructions.swift
//  Onboarding
//
//  Created by Dmytro Hetman on 07.06.2024.
//

import Foundation

protocol NetworkRequestBodyConvertible {
    
    var data: Data? { get }
    var queryItems: [URLQueryItem]? { get }
    var parameters: [String : Any]? { get }
    
}

struct OnboardingItemsInstruction: NetworkRequestBodyConvertible {
    
    var data: Data? { nil }
    var queryItems: [URLQueryItem]? { nil }
    var parameters: [String : Any]? { nil }
    
}
