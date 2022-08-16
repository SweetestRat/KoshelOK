//
//  StartScreenPresenter.swift
//  Wallet
//
//  Created by Владислава Гильде on 12.08.2022.
//

import Foundation

class StartScreenPresenter: StartScreenPresenterProtocol {
    private let service: StartScreenServiceProtocol?
    private let router: StartScreenRouterProtocol?
    weak var view: StartScreenViewProtocol?
    
    init(service: StartScreenServiceProtocol, router: StartScreenRouterProtocol) {
        self.service = service
        self.router = router
    }
    
    func actionButtonDidTap() {
        router?.openAuthorization()
    }
}
