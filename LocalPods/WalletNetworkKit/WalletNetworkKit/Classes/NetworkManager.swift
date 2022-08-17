//
//  NetworkManager.swift
//  Pods-Wallet
//
//  Created by Владислава Гильде on 13.08.2022.
//

import Foundation

final public class NetworkManager {
    var urlRequestConstructor = URLRequestConstructor()
    
    public init() {}
    
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        return decoder
    }()
    
    private let session = URLSession.shared

    public func loadRequest<T: NetworkRequestProtocol>(request: T, completion: @escaping (Result<T.Model, Error>) -> Void) {
        guard let url = try? urlRequestConstructor.constractURLRequest(from: request) else {
            completion(.failure(NSError.defaultError))
            return
        }
        
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            print(response)
            
            if let data = data {
                do {
                    let object = try self.decoder.decode(T.Model.self, from: data)
                    completion(.success(object))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}
