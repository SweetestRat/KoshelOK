//
//  CurrencySeletionPresenter.swift
//  Wallet
//
//  Created by Владислава Гильде on 12.08.2022.
//

import Foundation

class CurrencySeletionPresenter: CurrencySeletionPresenterProtocol {
    private var model: CurrencySeletionModelProtocol?
    private var router: CurrencySeletionRouterProtocol?
    private weak var view: CurrencySeletionViewProtocol?
    
    private var selectedIndexPathRow: Int = 0
    
    init(model: CurrencySeletionModelProtocol, router: CurrencySeletionRouterProtocol, view: CurrencySeletionViewProtocol) {
        self.model = model
        self.router = router
        self.view = view
    }
    
    func getSelectedRow() -> Int? {
        return selectedIndexPathRow
    }
    
    func setSelectedRow(row: Int) {
        selectedIndexPathRow = row
    }
    
    func controllerLoaded() {
        model?.getData()
    }
}