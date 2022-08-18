//
//  CurrencyViewModelFactory.swift
//  Wallet
//
//  Created by Danila on 18.08.2022.
//

import Foundation

class CurrencyViewModelFactory {
    func produce(from: Currency) -> CurrencyViewModel {
        CurrencyViewModel(symbol: from.shortName, fullName: from.longName)
    }
}
