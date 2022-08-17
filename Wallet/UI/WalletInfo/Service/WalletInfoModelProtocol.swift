//
//  WalletInfoModelProtocol.swift
//  Wallet
//
//  Created by Владислава Гильде on 13.08.2022.
//

import Foundation

protocol WalletInfoServiceProtocol {
    func getWalletInfo(userId: Int, walletId: Int, completion: @escaping (Result<Wallet, Error>) -> Void)
}
