//
//  WalletInfoPresenter.swift
//  Wallet
//
//  Created by Владислава Гильде on 13.08.2022.
//

import Foundation

class WalletInfoPresenter: WalletInfoPresenterProtocol {
    private var model: WalletInfoModelProtocol?
    private var router: WalletInfoRouterProtocol?
    private weak var view: WalletInfoViewProtocol?
    
    init(model: WalletInfoModelProtocol, router: WalletInfoRouterProtocol, view: WalletInfoViewController) {
        self.model = model
        self.router = router
        self.view = view
    }
}
