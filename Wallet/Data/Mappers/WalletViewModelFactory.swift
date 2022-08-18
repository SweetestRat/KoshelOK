//
//  WalletViewModelFactory.swift
//  Wallet
//
//  Created by Danila on 18.08.2022.
//

import Foundation

class WalletViewModelFactory {
    private let balanceFactory: BalanceViewModelFactory
    
    init(balanceFactory: BalanceViewModelFactory) {
        self.balanceFactory = balanceFactory
    }
    
    func produce(from: Wallet) -> WalletViewModel {
        WalletViewModel(
            name: from.name,
            balance: balanceFactory.produce(from: from.balance),
            income: balanceFactory.produce(from: from.income),
            expanse: balanceFactory.produce(from: from.expense)
        )
    }
}
