//
//  InttoStringFormatter.swift
//  Wallet
//
//  Created by Владислава Гильде on 16.08.2022.
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
    
    func format(balance: BalanceViewModel) -> String {
        formatter.currencySymbol = balance.currency.symbol
        return formatter.string(from: balance.value as NSNumber) ?? ""
    }
}
