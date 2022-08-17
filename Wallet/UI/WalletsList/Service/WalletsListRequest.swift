//
//  WalletsListRequest.swift
//  Wallet
//
//  Created by Владислава Гильде on 16.08.2022.
//

import Foundation
import WalletNetworkKit

struct GetWalletsModel: Encodable {}

struct WalletsListRequest: NetworkRequestProtocol {
    typealias Model = [Wallet]
    
    var path: String { "/koshelok/wallet" }
    var parameters: [String: String]?
    var method: RequestMethod { .get }
    var headers: [String : String]?
    
    init(userId: Int) {
        self.headers = ["userId": "\(userId)"]
    }
}
