//
//  UIFontExtension.swift
//  WalletDesignKit
//
//  Created by Владислава Гильде on 11.08.2022.
//

import UIKit

public extension UIFont {
    static func SFProRegular(size: CGFloat) -> UIFont {
        return systemFont(ofSize: size, weight: .regular)
    }
    
    static func SFProBold(size: CGFloat) -> UIFont {
        return systemFont(ofSize: size, weight: .bold)
    }
    
    static func SFProSemiBold(size: CGFloat) -> UIFont {
        return systemFont(ofSize: size, weight: .semibold)
    }
    
    static func SFProMedium(size: CGFloat) -> UIFont {
        return systemFont(ofSize: size, weight: .medium)
    }
    
    static func SFProLight(size: CGFloat) -> UIFont {
        return systemFont(ofSize: size, weight: .light)
    }
}
