//
//  Income.swift
//  Wallet
//
//  Created by Владислава Гильде on 16.08.2022.
//

import Foundation

struct Income: Decodable {
    let currency: Currency
    let amount: String
}
