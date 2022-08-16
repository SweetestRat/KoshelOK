//
//  CategoryRequest.swift
//  Wallet
//
//  Created by Alexandr Sokolov on 16.08.2022.
//

import Foundation
import WalletNetworkKit

enum CategoryRequestType {
    case loadCategories
    case createCategory(category: CreateCategoryModel)
}

struct CreateCategoryModel: Encodable {
    let name: String
    let iconId: String
}

extension CategoryRequestType: NetworkRequestProtocol {
    typealias Model = Category
    
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
        case .createCategory(let category):
            return try? JSONEncoder().encode(category)
        }
    }
}

struct CategoryRequest: NetworkRequestProtocol {
    typealias Model = [Category]
    
    var path: String { "/koshelok/category" }
    var parameters: [String: String]?
    var method: RequestMethod
    
    init(parameters: [String: String]?, method: RequestMethod) {
        self.parameters = parameters
        self.method = method
    }
}
