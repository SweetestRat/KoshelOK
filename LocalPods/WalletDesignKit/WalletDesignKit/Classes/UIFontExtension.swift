//
//  UIFontExtension.swift
//  WalletDesignKit
//
//  Created by Владислава Гильде on 11.08.2022.
//

import UIKit

public extension UIFont {

    static let designSFProRegular13 = systemFont(ofSize: 13, weight: .regular)
    
    static let designSFProRegular17 = systemFont(ofSize: 17, weight: .regular)
    
    static func SFProBold(size: CGFloat) -> UIFont {
        return systemFont(ofSize: size, weight: .bold)
    }
    
    static func SFProSemiBold(size: CGFloat) -> UIFont {
        return systemFont(ofSize: size, weight: .semibold)
    }
    
    static let designSFProMedium16 = systemFont(ofSize: 16, weight: .medium)
    
    static let designSFProMedium32 = systemFont(ofSize: 32, weight: .medium)

    static func SFProLight(size: CGFloat) -> UIFont {
        return systemFont(ofSize: size, weight: .light)
    }
}
