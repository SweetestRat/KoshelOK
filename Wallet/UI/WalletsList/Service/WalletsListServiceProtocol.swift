//
//  WalletsListModelProtocol.swift
//  Wallet
//
//  Created by Владислава Гильде on 12.08.2022.
//

import Foundation
import WalletNetworkKit

protocol WalletsListServiceProtocol {
    func getAllWallets(userId: Int, completion: @escaping (Result<[Wallet], Error>) -> Void)
    func getWalletsModels() -> [Wallet]?
    func deleteWallet(userId: Int, data: Wallet, completion: @escaping (Result<NoReply, Error>) -> Void)
}
