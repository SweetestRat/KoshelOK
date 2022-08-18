//
//  NetworkRequest.swift
//  Pods-Wallet
//
//  Created by Владислава Гильде on 13.08.2022.
//

import Foundation

public enum RequestMethod: String {
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
    var parameters: [String: String]? { get }
    var headers: [String: String]? { get }
    var method: RequestMethod { get }
    var body: Data? { get }
}

public extension NetworkRequestProtocol {
    var baseUrl: String { "http://34.116.166.170:9090" }
    var body: Data? { nil }
    var headers: [String: String]? { nil }
    var path: String { "" }
}
