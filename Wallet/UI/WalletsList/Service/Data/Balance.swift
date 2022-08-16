//
//  Balance.swift
//  Wallet
//
//  Created by Danila on 12.08.2022.
//

import Foundation

class BalanceFormatter {
    private lazy var formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.groupingSeparator = " "
        formatter.decimalSeparator = ","
        return formatter
    }()
    static let instance: BalanceFormatter = BalanceFormatter()
    
    private init() {
    }
    
    func format(balance: Balance) -> String {
        formatter.currencySymbol = balance.currency.symbol
        return formatter.string(from: balance.value as NSNumber) ?? ""
    }
}

struct Balance {    
    let value: Int
    let currency: Currency
    
    func toString() -> String {
        return BalanceFormatter.instance.format(balance: self)
    }
}
