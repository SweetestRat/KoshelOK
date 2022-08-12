//
//  WalletsListPresenter.swift
//  Wallet
//
//  Created by Danila on 12.08.2022.
//

import Foundation

class WalletsListScreenPresenter: WalletsListPresenterProtocol {
    weak var controller: WalletsListControllerProtocol?
    
    func controllerLoaded() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()) { [weak self] in
            self?.controller?.updateWalletsList(
                wallets: Array(repeating:
                                Wallet(name: "Wallet Name", icon: "", balance: Balance(value: 125, currency: Currency(symbol: "$"))), count: 30))
        }
    }
    
    func createWalletClicked() {
        
    }
    
    func didTapWallet() {
        
    }

}
