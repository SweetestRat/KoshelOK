//
//  CategorySelectionPresenter.swift
//  Wallet
//
//  Created by Alexandr Sokolov on 14.08.2022.
//

import Foundation

class CategorySelectionPresenter: CategorySelectionPresenterProtocol {
    
    private var service: CategorySelectionServiceProtocol
    private var router: CategorySelectionRouterProtocol
    weak var view: CategorySelectionViewProtocol?
    
    private var selectedIndexPathRow: Int = 0
    
    init(service: CategorySelectionServiceProtocol, router: CategorySelectionRouterProtocol) {
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
    }
    
    func didTapBarButton() {}
}
