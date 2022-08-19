//
//  WalletOperationsServiceProtocol.swift
//  Wallet
//
//  Created by Владислава Гильде on 17.08.2022.
//

import Foundation
import WalletNetworkKit

protocol WalletOperationsServiceProtocol {
    func getWalletOperations(userId: Int, walletId: Int, completion: @escaping (Result<[Operation], Error>) -> Void)
    func deleteOperation(userId: Int, walletId: Int, transactionId: Int, completion: @escaping (Result<NoReply, Error>) -> Void)
    func getOperations() -> [[Operation]]
    func setOperations(operations: [[Operation]])
    func deleteTransaction(section: Int, row: Int)
    func deleteTransactionSection(section: Int)
}
