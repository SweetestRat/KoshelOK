//
//  OperationRequest.swift
//  Wallet
//
//  Created by Владислава Гильде on 17.08.2022.
//

import Foundation
import WalletNetworkKit

struct GetOperationRequest: NetworkRequestProtocol {
    typealias Model = [Operation]

    var path: String
    var parameters: [String: String]? { nil }
    var method: RequestMethod { .get }
    var headers: [String : String]?
    var body: Data? { nil }

    init(userId: Int, walletId: Int) {
        self.headers = ["userId": "\(userId)"]
        self.path = "/koshelok/wallet/\(walletId)/transaction"
    }
}

struct DeleteOperationRequest: NetworkRequestProtocol {
    typealias Model = NoReply

    var path: String
    var parameters: [String: String]? { nil }
    var method: RequestMethod { .delete }
    var headers: [String : String]?
    var body: Data? { nil }

    init(userId: Int, walletId: Int, transactionId: Int) {
        self.headers = ["userId": "\(userId)"]
        self.path = "/koshelok/wallet/\(walletId)/transaction/\(transactionId)"
    }
}
