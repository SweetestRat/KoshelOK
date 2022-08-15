//
//  CurrencySelectionPresenter.swift
//  Wallet
//
//  Created by Владислава Гильде on 12.08.2022.
//

import Foundation

class CurrencySelectionPresenter: CurrencySelectionPresenterProtocol {
    private let service: CurrencySelectionServiceProtocol?
    private let router: CurrencySelectionRouterProtocol?
    weak var view: CurrencySelectionViewProtocol?
    
    private var selectedIndexPathRow: Int = 0
    
    init(service: CurrencySelectionServiceProtocol, router: CurrencySelectionRouterProtocol) {
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
