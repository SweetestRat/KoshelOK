//
//  CurrencySeletionPresenter.swift
//  Wallet
//
//  Created by Владислава Гильде on 12.08.2022.
//

import Foundation

class CurrencySeletionPresenter: CurrencySeletionPresenterProtocol {
    private let service: CurrencySeletionServiceProtocol?
    private let router: CurrencySeletionRouterProtocol?
    weak var view: CurrencySeletionViewProtocol?
    
    private var selectedIndexPathRow: Int = 0
    
    init(service: CurrencySeletionServiceProtocol, router: CurrencySeletionRouterProtocol) {
        self.service = service
        self.router = router
    }
    
    func getSelectedRow() -> Int? {
        return selectedIndexPathRow
    }
    
    func setSelectedRow(row: Int) {
        selectedIndexPathRow = row
    }
    
    func controllerLoaded() {
        service?.getData()
    }
}
