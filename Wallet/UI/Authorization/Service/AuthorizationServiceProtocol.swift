//
//  AuthorizationModelProtocol.swift
//  Wallet
//
//  Created by Alexandr Sokolov on 13.08.2022.
//

import Foundation

protocol AuthorizationServiceProtocol {
    func createUser(data: Data, completion: @escaping (Result<User, Error>) -> Void)
}
