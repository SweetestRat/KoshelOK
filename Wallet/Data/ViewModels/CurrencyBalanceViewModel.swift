//
//  CurrencyBalanceViewModel.swift
//  Wallet
//
//  Created by Владислава Гильде on 19.08.2022.
//

import Foundation

struct CurrencyBalanceViewModel {
    let value: BalanceViewModel
    let currency: CurrencyViewModel
    let income: BalanceViewModel
    let expanse: BalanceViewModel
    
    init(value: BalanceViewModel, currency: CurrencyViewModel, income: BalanceViewModel, expanse: BalanceViewModel) {
        self.value = value
        self.currency = currency
        self.income = income
        self.expanse = expanse
    }
    
    func valueToString() -> String {
        return BalanceFormatter.instance.format(balance: value)
    }
    
    func incomeToString() -> String {
        return BalanceFormatter.instance.format(balance: income)
    }
    
    func expanseToString() -> String {
        return BalanceFormatter.instance.format(balance: expanse)
    }
}
