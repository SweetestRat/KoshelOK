//
//  Balance.swift
//  Wallet
//
//  Created by Владислава Гильде on 16.08.2022.
//

import Foundation

struct Balance: Codable {
    let currency: Currency
    let amount: String
    
    private enum CodingKeys : String, CodingKey {
        case currency = "currencyDto"
        case amount
    }
}
