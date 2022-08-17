//
//  CreateWalletModelProtocol.swift
//  Wallet
//
//  Created by Владислава Гильде on 12.08.2022.
//

import Foundation

protocol CreateWalletServiceProtocol {
    func createWallet(data: CreateWalletModel, completion: @escaping (Result<Wallet, Error>) -> Void)
}
