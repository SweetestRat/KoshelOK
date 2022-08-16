//
//  CurrencySelectionPresenter.swift
//  Wallet
//
//  Created by Владислава Гильде on 12.08.2022.
//

import Foundation

class CurrencySelectionPresenter: CurrencySelectionPresenterProtocol {
    private var model: CurrencySelectionModelProtocol?
    private var router: CurrencySelectionRouterProtocol?
    private weak var view: CurrencySelectionViewProtocol?
    
    private var selectedIndexPathRow: Int = 0
    
    init(model: CurrencySelectionModelProtocol, router: CurrencySelectionRouterProtocol, view: CurrencySelectionViewProtocol) {
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
