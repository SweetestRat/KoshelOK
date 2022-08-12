//
//  StartScreenPresenter.swift
//  Wallet
//
//  Created by Владислава Гильде on 12.08.2022.
//

import Foundation

class StartScreenPresenter: StartScreenPresenterProtocol {
    var model: StartScreenModelProtocol?
    var router: StartScreenRouterProtocol?
    weak var view: StartScreenViewProtocol?
    
    init(model: StartScreenModelProtocol, router: StartScreenRouterProtocol, view: StartScreenViewProtocol) {
        self.model = model
        self.router = router
        self.view = view
    }
    
    func actionButtonDidTap() {
        router?.openWalletsList()
    }
}
