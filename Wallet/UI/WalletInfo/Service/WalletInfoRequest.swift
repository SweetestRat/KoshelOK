//
//  WalletInfoRequest.swift
//  Wallet
//
//  Created by Владислава Гильде on 18.08.2022.
//

import Foundation
import WalletNetworkKit

struct WalletInfoRequest: NetworkRequestProtocol {
    typealias Model = Wallet
    
    var path: String
    var parameters: [String: String]? { nil }
    var method: RequestMethod { .get }
    var headers: [String : String]?
    var body: Data? { nil }
    
    init(userId: Int, walletId: Int) {
        self.headers = ["userId": "\(userId)"]
        self.path = "/koshelok/wallet/\(walletId)"
    }
}
