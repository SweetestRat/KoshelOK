//
//  Operation.swift
//  Wallet
//
//  Created by Владислава Гильде on 17.08.2022.
//

import Foundation

struct Operation: Decodable {
    let id: Int
    let balanceDto: Balance
    let isIncome: Bool
    let date: Int
    let category: Category
}
