//
//  Parameters.swift
//  Onboarding
//
//  Created by Dmytro Hetman on 08.06.2024.
//

import UIKit

enum Parameters {
    
    enum OnboardingPage {
        
        enum ActionButton {
            static let textColor = UIColor.hexFFFFFF
            static let lineHeight: CGFloat = 20
            static let lineSpacing: CGFloat = 0
            static let font = CustomFont.sfProDisplay(ofSize: 17, weight: .semibold) ?? UIFont.systemFont(ofSize: 17, weight: .semibold)
            static let kern = 0.3
        }
        
        enum OnboardingItem {
            
            enum MainText {
                static let text = "Let’s setup App for you"
                static let foregroundColor = UIColor.hex1A1A1A
                static let lineHeight: CGFloat = 30
                static let font = CustomFont.sfProDisplay(ofSize: 26, weight: .bold) ?? UIFont.systemFont(ofSize: 26, weight: .bold)
                static let kern = 0.37
                
                
                static let title = {
                    let paragraphStyle = NSMutableParagraphStyle()
                    paragraphStyle.minimumLineHeight = MainText.lineHeight
                    paragraphStyle.maximumLineHeight = MainText.lineHeight
                    
                    let attributes: [NSAttributedString.Key : Any] = [
                        NSAttributedString.Key.foregroundColor: MainText.foregroundColor,
                        NSAttributedString.Key.paragraphStyle: paragraphStyle,
                        NSAttributedString.Key.font: MainText.font,
                        NSAttributedString.Key.kern: MainText.kern]
                    
                    let text = NSMutableAttributedString(string: MainText.text, attributes: attributes)
                    return text
                }()
            }
            
            enum QuestionText {
                static let foregroundColor = UIColor.hex1A1A1A
                static let lineHeight: CGFloat = 24
                static let lineSpacing: CGFloat = 0
                static let font = CustomFont.sfProDisplay(ofSize: 20, weight: .semibold) ?? UIFont.systemFont(ofSize: 26, weight: .semibold)
                static let kern = -0.7
                
            }
            
            
        }
        
        enum SubscriptionItem {
            
            enum ManagerBarView {
                
                static let cancelIcon = {
                    UIImage.iconCancel
                }()
            }
            
            enum InfoText {
                
                static let title = {
                    

                    let paragraphStyle = NSMutableParagraphStyle()
                    paragraphStyle.minimumLineHeight = 36
                    paragraphStyle.maximumLineHeight = 36
                    
                    let font = CustomFont.sfProDisplay(ofSize: 32, weight: .bold) ?? .systemFont(ofSize: 32, weight: .bold)
                    let attributes: [NSAttributedString.Key : Any] = [
                        NSAttributedString.Key.foregroundColor: UIColor.hex1A1A1A,
                        NSAttributedString.Key.paragraphStyle: paragraphStyle,
                        NSAttributedString.Key.font: font,
                        NSAttributedString.Key.kern: 0.37]
                    
                    let text = NSMutableAttributedString(string: "Discover all\nPremium features", attributes: attributes)
                    return text
                }()
                
                static let price = {
                    

                    let priceParagraphStyle = NSMutableParagraphStyle()
                    priceParagraphStyle.lineSpacing = 0
                    priceParagraphStyle.minimumLineHeight = 20
                    priceParagraphStyle.maximumLineHeight = 20
                    
                    let textParagraphStyle = NSMutableParagraphStyle()
                    textParagraphStyle.lineSpacing = 0
                    textParagraphStyle.minimumLineHeight = 20
                    textParagraphStyle.maximumLineHeight = 20
                    let priceFont = CustomFont.sfProDisplay(ofSize: 16, weight: .bold) ?? .systemFont(ofSize: 16, weight: .bold)
                    let termsFont = CustomFont.sfProDisplay(ofSize: 16, weight: .medium) ?? .systemFont(ofSize: 16, weight: .medium)
                    let priceAttributes: [NSAttributedString.Key : Any] = [
                        NSAttributedString.Key.foregroundColor: UIColor.hex1A1A1A,
                        NSAttributedString.Key.paragraphStyle: priceParagraphStyle,
                        NSAttributedString.Key.font: priceFont
                    ]
                    let infoAttributes: [NSAttributedString.Key : Any] = [
                        NSAttributedString.Key.foregroundColor: UIColor.hex6E6E73,
                        NSAttributedString.Key.paragraphStyle: textParagraphStyle,
                        NSAttributedString.Key.font: termsFont
                    ]
                    
                    let startPartInfoText = NSMutableAttributedString(string: "Try 7 days for free\nthen ", attributes: infoAttributes)
                    let pricePartText = NSMutableAttributedString(string: "$6.99", attributes: priceAttributes)
                    let finalPartInfoText = NSMutableAttributedString(string: " per week, auto-renewable", attributes: infoAttributes)

                    pricePartText.append(finalPartInfoText)
                    startPartInfoText.append(pricePartText)
                    return startPartInfoText
                }()
                
            }
            
            enum TermsLabel {
                static let attributedText = {
                    let paragraphStyle = NSMutableParagraphStyle()
                    paragraphStyle.lineSpacing = 0
                    paragraphStyle.minimumLineHeight = 14
                    paragraphStyle.maximumLineHeight = 14
                    let termsFont = CustomFont.sfProDisplay(ofSize: 12, weight: .regular) ?? .systemFont(ofSize: 12, weight: .regular)
                    let grayTextAttributes: [NSAttributedString.Key : Any] = [
                        NSAttributedString.Key.foregroundColor: UIColor.hex6E6E73,
                        NSAttributedString.Key.paragraphStyle: paragraphStyle,
                        NSAttributedString.Key.font: termsFont,
                        NSAttributedString.Key.kern: 0.75]
                    let blueTextAttributes: [NSAttributedString.Key : Any] = [
                        NSAttributedString.Key.foregroundColor: UIColor.hex208BFF,
                        NSAttributedString.Key.paragraphStyle: paragraphStyle,
                        NSAttributedString.Key.font: termsFont,
                        NSAttributedString.Key.kern: 0.75
                    ]
                    
                    let startAttributedText = NSMutableAttributedString(
                        string: "By continuing you accept our:\n",
                        attributes: grayTextAttributes)
                    
                    let termsOfUseText = NSMutableAttributedString(
                        string: PrivacyCenterOption.termsOfUse.title,
                        attributes: blueTextAttributes)
                    termsOfUseText.addAttribute(
                        .link,
                        value: PrivacyCenterOption.termsOfUse.link,
                        range: termsOfUseText.fullLengthRange)
                    
                    let commaText = NSAttributedString(string: ", ", attributes: grayTextAttributes)
                    let privacyPolicyText = NSMutableAttributedString(
                        string: PrivacyCenterOption.privacyPolicy.title,
                        attributes: blueTextAttributes)
                    privacyPolicyText.addAttribute(
                        .link,
                        value: PrivacyCenterOption.privacyPolicy.link,
                        range: privacyPolicyText.fullLengthRange)
                    
                    let andText = NSAttributedString(string: ", ", attributes: grayTextAttributes)
                    
                    let subscriptionTermsText = NSMutableAttributedString(
                        string: PrivacyCenterOption.subscriptionTerms.title,
                        attributes: blueTextAttributes)
                    subscriptionTermsText.addAttribute(
                        .link,
                        value: PrivacyCenterOption.subscriptionTerms.link,
                        range: subscriptionTermsText.fullLengthRange)
                    
                    startAttributedText.append(termsOfUseText)
                    startAttributedText.append(commaText)
                    startAttributedText.append(privacyPolicyText)
                    startAttributedText.append(andText)
                    startAttributedText.append(subscriptionTermsText)
                    return startAttributedText
                }()
            }
            
        }
    }
    
}
