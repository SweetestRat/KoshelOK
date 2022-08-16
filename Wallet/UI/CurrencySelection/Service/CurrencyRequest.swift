//
//  CurrencyRequest.swift
//  Wallet
//
//  Created by Владислава Гильде on 16.08.2022.
//

import Foundation
import WalletNetworkKit

struct CurrencyRequest: NetworkRequestProtocol {
    typealias Model = [Currency]
    
    var path: String { "/koshelok/currency" }
    var parameters: [String: String]?
    var method: RequestMethod
    
    init(parameters: [String: String]?, method: RequestMethod) {
        self.parameters = parameters
        self.method = method
    }
}
