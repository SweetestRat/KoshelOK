//
//  BalanceViewModel.swift
//  Wallet
//
//  Created by Владислава Гильде on 16.08.2022.
//

import Foundation

struct BalanceViewModel {
    let value: Int
    let currency: CurrencyViewModel
    
    init(value: Int, currency: CurrencyViewModel) {
        self.value = value
        self.currency = currency
    }
    
    func toString() -> String {
        return BalanceFormatter.instance.format(balance: self)
    }
}
