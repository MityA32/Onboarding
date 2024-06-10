//
//  Constants.swift
//  Onboarding
//
//  Created by Dmytro Hetman on 06.06.2024.
//

import UIKit

enum CustomFont {
    static func sfUIText(ofSize size: CGFloat, weight: Weight) -> UIFont? {
        UIFont(name: "SFUIText\(weight.rawValue)", size: size)
    }
    
    static func sfProDisplay(ofSize size: CGFloat, weight: Weight) -> UIFont? {
        UIFont(name: "SFProDisplay\(weight.rawValue)", size: size)
    }
    
    static func sfPro(ofSize size: CGFloat, weight: Weight) -> UIFont? {
        UIFont(name: "SF-Pro", size: size)
    }
    
    
    enum Weight: String {
        case bold = "-Bold"
        case medium = "-Medium"
        case regular = "-Regular"
        case semibold = "-Semibold"
    }
}


