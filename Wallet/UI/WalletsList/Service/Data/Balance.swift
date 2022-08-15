//
//  Balance.swift
//  Wallet
//
//  Created by Danila on 12.08.2022.
//

import Foundation

struct Balance {    
    let value: Int
    let currency: Currency
    
    func toString() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: currency.symbol)
        return formatter.string(from: value as NSNumber) ?? ""
    }
}
