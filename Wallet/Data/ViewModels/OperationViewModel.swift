//
//  OperationViewModel.swift
//  Wallet
//
//  Created by Владислава Гильде on 17.08.2022.
//

import Foundation

struct OperationViewModel {
    let category: String
    let balance: String
    let date: String
    let time: String
    
    init(category: String, balance: String, date: String, time: String) {
        self.category = category
        self.balance = balance
        self.date = date
        self.time = time
    }
}
