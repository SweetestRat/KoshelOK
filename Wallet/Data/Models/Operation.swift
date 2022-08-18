//
//  Operation.swift
//  Wallet
//
//  Created by Владислава Гильде on 17.08.2022.
//

import Foundation

struct Operation: Decodable {
    let id: Int
    let balance: Balance
    let isIncome: Bool
    let date: Int
    let category: Category
    
    private enum CodingKeys : String, CodingKey {
        case id
        case balance = "balanceDto"
        case isIncome = "incomeFlag"
        case date
        case category = "categoryDto"
    }
}
