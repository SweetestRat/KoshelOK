//
//  SetupCategoryRequest.swift
//  Wallet
//
//  Created by Alexandr Sokolov on 18.08.2022.
//

import Foundation
import WalletNetworkKit

struct SetupCategoryModel: Encodable {
    let name: String
    let iconName: String
    let iconColor: String
}

struct SetupCategoryRequest: NetworkRequestProtocol {
    typealias Model = Category
    
    var path: String { "/koshelok/category" }
    var parameters: [String: String]? { nil }
    var method: RequestMethod { .post }
    var body: Data?
    var headers: [String : String]?

    init(data: Data, userId: Int) {
        self.body = data
        self.headers = ["userId": "\(userId)"]
    }
}
