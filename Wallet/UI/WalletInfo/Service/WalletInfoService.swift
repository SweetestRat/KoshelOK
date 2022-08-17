//
//  WalletInfoModel.swift
//  Wallet
//
//  Created by Владислава Гильде on 13.08.2022.
//

import Foundation
import WalletNetworkKit

class WalletInfoService: WalletInfoServiceProtocol {
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
}
