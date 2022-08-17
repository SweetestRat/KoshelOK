//
//  CreateWalletRequest.swift
//  Wallet
//
//  Created by Владислава Гильде on 17.08.2022.
//

import Foundation
import WalletNetworkKit

struct CreateWalletModel: Encodable {
    let name: String
    let currencyId: Int
}

struct CreateWalletRequest: NetworkRequestProtocol {
    typealias Model = Wallet
    
    var path: String { "/koshelok/wallet" }
    var parameters: [String: String]? { nil }
    var method: RequestMethod { .post }
    var body: Data?

    init(data: Data) {
        self.body = data
    }
}
