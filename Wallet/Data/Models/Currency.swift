//
//  Currency.swift
//  Wallet
//
//  Created by Владислава Гильде on 16.08.2022.
//

import Foundation

struct Currency: Decodable {
    let id: Int
    let symbol: String
    let longName: String
}
