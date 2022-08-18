//
//  CreateOperationRequest.swift
//  Wallet
//
//  Created by Danila on 18.08.2022.
//

import Foundation
import WalletNetworkKit

struct CreateOperationModel: Encodable {
    let balanceDto: Balance
    let date: Int
    let categoryDto: Category
    let income: Bool
}

struct CreateOperationRequest: NetworkRequestProtocol {
    typealias Model = Operation
    
    var path: String
    var parameters: [String: String]? { nil }
    var method: RequestMethod { .post }
    var body: Data?
    var headers: [String : String]?

    init(data: Data, userId: Int, walletId: Int) {
        self.body = data
        self.path = "/wallet/\(walletId)/transaction"
        self.headers = ["userId": "\(userId)"]
    }
}
