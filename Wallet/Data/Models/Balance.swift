//
//  Balance.swift
//  Wallet
//
//  Created by Владислава Гильде on 16.08.2022.
//

import Foundation

struct Balance: Decodable {
    let currency: Currency
    let amount: String
}
