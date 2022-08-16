//
//  CategoryRequest.swift
//  Wallet
//
//  Created by Alexandr Sokolov on 16.08.2022.
//

import Foundation
import WalletNetworkKit

struct CategoryRequest: NetworkRequestProtocol {
    typealias Model = CategoryResult
    
    var parameters: [String: String]
    let method: RequestMethod = .get
    
}
