//
//  UIColorExtension.swift
//  WalletDesignKit
//
//  Created by Владислава Гильде on 11.08.2022.
//

import UIKit

public extension UIColor {
    
    convenience init?(hex: String) {
        let r, g, b: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 6 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
                    g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
                    b = CGFloat(hexNumber & 0x0000ff) / 255
                    self.init(red: r, green: g, blue: b, alpha: 1)
                    return
                }
            }
        }

        return nil
    }
    
    static var background: UIColor? {
        let bundle = Bundle.walletDesignKit
        return .init(named: "BackgroundColor", in: bundle, compatibleWith: nil)
    }
    
    static var activeButtonBackground: UIColor? {
        let bundle = Bundle.walletDesignKit
        return .init(named: "ActiveButtonBackground", in: bundle, compatibleWith: nil)
    }
    
    static var inactiveButtonBackground: UIColor? {
        let bundle = Bundle.walletDesignKit
        return .init(named: "InactiveButtonBackground", in: bundle, compatibleWith: nil)
    }
    
    static var activeTouchButtonBackground: UIColor? {
        let bundle = Bundle.walletDesignKit
        return .init(named: "ActiveTouchButtonBackground", in: bundle, compatibleWith: nil)
    }
    
    static var staticMilkTextColor: UIColor? {
        let bundle = Bundle.walletDesignKit
        return .init(named: "StaticMilkColor", in: bundle, compatibleWith: nil)
    }
    
    static var buttonTextInactiveColor: UIColor? {
        let bundle = Bundle.walletDesignKit
        return .init(named: "ButtonTextInactiveColor", in: bundle, compatibleWith: nil)
    }
    
    static var buttonTextActiveColor: UIColor? {
        let bundle = Bundle.walletDesignKit
        return .init(named: "ButtonTextActiveColor", in: bundle, compatibleWith: nil)
    }
    
    static var lightTextPrimaryColor: UIColor? {
        let bundle = Bundle.walletDesignKit
        return .init(named: "LightTextColor", in: bundle, compatibleWith: nil)
    }
    
    static var darkTextPrimaryColor: UIColor? {
        let bundle = Bundle.walletDesignKit
        return .init(named: "DarkTextColor", in: bundle, compatibleWith: nil)
    }
    
    static var incomeColor: UIColor? {
        let bundle = Bundle.walletDesignKit
        return .init(named: "IncomeColor", in: bundle, compatibleWith: nil)
    }
    
    static var designRedColor: UIColor? {
        let bundle = Bundle.walletDesignKit
        return .init(named: "ExpansesColor", in: bundle, compatibleWith: nil)
    }
    
    static var inputPlaceholderColor: UIColor? {
        let bundle = Bundle.walletDesignKit
        return .init(named: "InputPlaceholderColor", in: bundle, compatibleWith: nil)
    }
    
    static var strokeColor: UIColor? {
        let bundle = Bundle.walletDesignKit
        return .init(named: "StrokeColor", in: bundle, compatibleWith: nil)
    }
}
