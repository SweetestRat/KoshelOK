//
//  UIColorExtension.swift
//  WalletDesignKit
//
//  Created by Владислава Гильде on 11.08.2022.
//

import UIKit

public extension UIColor {
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
    
    static var incomeColor: UIColor? {
        let bundle = Bundle.walletDesignKit
        return .init(named: "IncomeColor", in: bundle, compatibleWith: nil)
    }
}
