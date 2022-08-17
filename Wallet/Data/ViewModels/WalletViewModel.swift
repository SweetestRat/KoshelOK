//
//  WalletViewModel.swift
//  Wallet
//
//  Created by Владислава Гильде on 16.08.2022.
//

import Foundation

struct WalletViewModel {
    let name: String
    let icon: String = "creditcard"
    let balance: BalanceViewModel
    let income: BalanceViewModel
    let expanse: BalanceViewModel
    
    func toString() -> String {
        return BalanceFormatter.instance.format(balance: balance)
    }
}
