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
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) { [weak self] in
            self?.controller?.updateWalletsList(wallets: Array(repeating: Wallet(name: "Wallet Name"), count: 10))
        }
    }
    
    func createWalletClicked() {
        
    }

}
