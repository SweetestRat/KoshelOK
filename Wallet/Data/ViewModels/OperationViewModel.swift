//
//  OperationViewModel.swift
//  Wallet
//
//  Created by Владислава Гильде on 17.08.2022.
//

import Foundation

struct OperationViewModel {
    let category: CategoryViewModel
    let balance: BalanceViewModel
    let date: String
    let time: String
    
    init(category: CategoryViewModel, balance: BalanceViewModel, date: String, time: String) {
        self.category = category
        self.balance = balance
        self.date = date
        self.time = time
    }
}
