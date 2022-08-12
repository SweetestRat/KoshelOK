//
//  CreateWalletRouter.swift
//  Wallet
//
//  Created by Владислава Гильде on 12.08.2022.
//

import Foundation
import UIKit

class CreateWalletRouter: CreateWalletRouterProtocol {
    var view: CreateWalletViewProtocol?
    
    init(view: CreateWalletViewController) {
        self.view = view
    }
    
    func openWalletsList() {
        // call WalletsList Assembly
    }
}
