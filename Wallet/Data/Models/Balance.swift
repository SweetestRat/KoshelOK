//
//  Balance.swift
//  Wallet
//
//  Created by Владислава Гильде on 16.08.2022.
//

import Foundation

struct Balance: Decodable, Encodable {
    let currencyDto: Currency
    let amount: String
}
