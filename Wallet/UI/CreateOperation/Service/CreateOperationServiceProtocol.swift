//
//  CreateOperationModel.swift
//  Wallet
//
//  Created by Danila on 13.08.2022.
//

import Foundation

protocol CreateOperationServiceProtocol {
    func createOperation(data: CreateOperationModel, walletId: Int, completion: @escaping (Result<Operation, Error>) -> Void)
}
