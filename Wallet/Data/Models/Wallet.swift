//
//  CreateWalletModels.swift
//  Wallet
//
//  Created by Владислава Гильде on 16.08.2022.
//

import Foundation

struct Wallet: Decodable {
    let id: Int
    let name: String
    let balance: Balance
    let income: Balance
    let expense: Balance
}
