//
//  WalletsListControllerProtocol.swift
//  Wallet
//
//  Created by Danila on 12.08.2022.
//

import UIKit

protocol WalletsListControllerProtocol: AnyObject {
    func updateWalletsList()
    func updateBalances(commonBalance: BalanceViewModel, income: BalanceViewModel, expanse: BalanceViewModel)
    func walletsLoadingError(error: String)
}
