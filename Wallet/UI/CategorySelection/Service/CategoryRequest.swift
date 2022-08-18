//
//  CategoryRequest.swift
//  Wallet
//
//  Created by Alexandr Sokolov on 16.08.2022.
//

import Foundation
import WalletNetworkKit

enum CategoryRequestType {
    case loadCategories(userId: Int)
    case createCategory(category: CreateCategoryModel, userId: Int)
}

struct CreateCategoryModel: Encodable {
    let name: String
    let iconId: String
}

extension CategoryRequestType: NetworkRequestProtocol {
    typealias Model = [Category]
    
    var path: String { "/koshelok/category" }
    
    var parameters: [String: String]? { return nil }
    
    var method: RequestMethod {
        switch self {
        case .loadCategories:
            return .get
        case .createCategory:
            return .post
        }
    }

    var body: Data? {
        switch self {
        case .loadCategories:
            return nil
        case .createCategory(let category, _):
            return try? JSONEncoder().encode(category)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .loadCategories(let userId), .createCategory(_, let userId):
            return ["userId": "\(userId)"]
        }
    }
}
