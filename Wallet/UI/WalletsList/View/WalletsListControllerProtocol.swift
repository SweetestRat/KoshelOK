//
//  WalletsListControllerProtocol.swift
//  Wallet
//
//  Created by Danila on 12.08.2022.
//

import UIKit

protocol WalletsListControllerProtocol: AnyObject {
    func updateWalletsList(wallets: [Wallet])
}
