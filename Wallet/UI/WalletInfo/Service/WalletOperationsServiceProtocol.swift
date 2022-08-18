//
//  WalletOperationsServiceProtocol.swift
//  Wallet
//
//  Created by Владислава Гильде on 17.08.2022.
//

import Foundation

protocol WalletOperationsServiceProtocol {
    func getWalletOperations(userId: Int, walletId: Int, completion: @escaping (Result<[Operation], Error>) -> Void)
}
