//
//  WalletInfoPresenter.swift
//  Wallet
//
//  Created by Владислава Гильде on 13.08.2022.
//

import Foundation

class WalletInfoPresenter: WalletInfoPresenterProtocol {
    private let service: WalletInfoServiceProtocol
    private let router: WalletInfoRouterProtocol
    weak var view: WalletInfoViewProtocol?
    
    init(service: WalletInfoServiceProtocol, router: WalletInfoRouterProtocol) {
        self.service = service
        self.router = router
    }
}
