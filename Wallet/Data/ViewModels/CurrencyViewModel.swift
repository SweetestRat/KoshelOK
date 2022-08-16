//
//  CurrencyViewModel.swift
//  Wallet
//
//  Created by Владислава Гильде on 16.08.2022.
//

import Foundation

struct CurrencyViewModel {
    let symbol: String
    let fullName: String
    
    init(symbol: String, fullName: String) {
        self.symbol = symbol
        self.fullName = fullName
    }
}
