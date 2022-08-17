//
//  OperationViewModel.swift
//  Wallet
//
//  Created by Владислава Гильде on 17.08.2022.
//

import Foundation

struct OperationViewModel {
    let category: Category
    let balance: String
    let date: String
    let time: String
    
    init(category: Category, balance: String, date: String, time: String) {
        self.category = category
        self.balance = balance
        self.date = date
        self.time = time
    }
}
