//
//  NSAttributedString+Extension.swift
//  Onboarding
//
//  Created by Dmytro Hetman on 08.06.2024.
//

import Foundation

extension NSAttributedString {
    var fullLengthRange: NSRange {
        NSRange(location: 0, length: self.length)
    }
}
