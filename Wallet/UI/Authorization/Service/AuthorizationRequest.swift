//
//  AuthorizationRequest.swift
//  Wallet
//
//  Created by Владислава Гильде on 16.08.2022.
//

import Foundation
import WalletNetworkKit

struct CreateUserModel: Encodable {
    let mail: String
}

struct AuthorizationRequest: NetworkRequestProtocol {
    typealias Model = User
    
    var path: String { "/koshelok/user" }
    var parameters: [String: String]? { nil }
    var method: RequestMethod { .post }
    var body: Data?
    
    init(data: Data) {
        self.body = data
    }
}
