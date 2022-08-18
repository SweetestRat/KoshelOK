//
//  BalanceViewModelFactory.swift
//  Wallet
//
//  Created by Danila on 18.08.2022.
//

import Foundation

class BalanceViewModelFactory {
    private let currencyFactory: CurrencyViewModelFactory
    
    init(currencyFactory: CurrencyViewModelFactory) {
        self.currencyFactory = currencyFactory
    }
    
    func produce(from: Balance) -> BalanceViewModel {
        BalanceViewModel(
            value: Int(from.amount) ?? 0,
            currency: currencyFactory.produce(from: from.currency)
        )
    }
}
