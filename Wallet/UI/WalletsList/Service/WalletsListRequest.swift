//
//  WalletsListRequest.swift
//  Wallet
//
//  Created by Владислава Гильде on 16.08.2022.
//

import Foundation
import WalletNetworkKit

enum RequestType {
    
}

struct WalletsListRequest: NetworkRequestProtocol {
    typealias Model = [Wallet]
    
    var path: String = "wallet"
    var parameters: [String: String]?
    var method: RequestMethod
    
    init(parameters: [String: String], method: RequestMethod) {
        self.parameters = parameters
        self.method = method
    }
}
