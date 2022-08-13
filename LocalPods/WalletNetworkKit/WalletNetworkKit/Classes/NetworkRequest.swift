//
//  NetworkRequest.swift
//  Pods-Wallet
//
//  Created by Владислава Гильде on 13.08.2022.
//

import Foundation

public enum RequestMethod {
    case get
    case post
    case put
    case patch
    case delete
}

public protocol NetworkRequestProtocol {
    associatedtype Model: Decodable
    
    var baseUrl: String { get }
    var path: String { get }
    var parameters: [String: String] { get }
    var method: RequestMethod { get }
}

public extension NetworkRequestProtocol {
    var baseUrl: String { "https://api.stackexchange.com" }
    var path: String { "/2.3/questions" }
}
