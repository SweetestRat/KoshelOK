//
//  CreateWalletModel.swift
//  Wallet
//
//  Created by Владислава Гильде on 12.08.2022.
//

import UIKit

class CreateWalletModel: CreateWalletModelProtocol {
    weak var presenter: CreateWalletPresenterProtocol?
    
    func createWallet() {
        // call api to create wallet
        // if success ->
        presenter?.openWalletsList()
    }
}
