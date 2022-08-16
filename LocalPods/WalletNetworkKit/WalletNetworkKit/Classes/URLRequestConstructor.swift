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

class URLRequestConstructor {
    func constractURLRequest<T: NetworkRequestProtocol>(from request: T) throws -> URLRequest {
        guard var components = URLComponents(string: request.baseUrl) else {
            throw NSError.defaultError
        }
        
        components.path = request.path
        components.queryItems = request.parameters?.map {
            URLQueryItem(name: $0.key, value: $0.value)
        }
        
        guard let url = components.url else { throw NSError.defaultError }
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = request.body
        urlRequest.httpMethod = request.method.stringValue
        
        return urlRequest
    }
}

private extension RequestMethod {
    var stringValue: String { rawValue.uppercased() }
}
