//
//  URLConstructor.swift
//  Pods-Wallet
//
//  Created by Владислава Гильде on 13.08.2022.
//

import Foundation

extension NSError {
    static let defaultError = NSError(domain: "ru.tinkoff.Wallet-D3", code: -1, userInfo: nil)
}

class URLConstructor {
    func constractURL<T: NetworkRequestProtocol>(from request: T) throws -> URL {
        var components = URLComponents(string: request.baseUrl)
        
        components?.path = request.path
        components?.queryItems = request.parameters.map {
            URLQueryItem(name: $0.key, value: $0.value)
        }
        
        guard let url = components?.url else { throw NSError.defaultError }
        
        return url
    }
}
