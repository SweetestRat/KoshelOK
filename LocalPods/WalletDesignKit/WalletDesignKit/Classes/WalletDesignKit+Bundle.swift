//
//  WalletDesignKit+Bundle.swift
//  WalletDesignKit
//
//  Created by Владислава Гильде on 11.08.2022.
//

import Foundation

extension Bundle {
    
    public static var walletDesignKit: Bundle {
        let bundle = Bundle(for: ClassForBundle.self)
        guard let resourcesBundleUrl = bundle.url(forResource: "WalletDesignKitResources", withExtension: "bundle"),
        let resourcesBundle = Bundle(url: resourcesBundleUrl) else {
            return bundle
        }
        return resourcesBundle
    }
    
    private class ClassForBundle {}
}
