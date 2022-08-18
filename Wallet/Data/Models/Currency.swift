//
//  Currency.swift
//  Wallet
//
//  Created by Владислава Гильде on 16.08.2022.
//

import Foundation

struct Currency: Decodable, Encodable {
    let id: Int
    let shortName: String
    let longName: String
}
