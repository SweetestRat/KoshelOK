//
//  SetupCategoryPresenter.swift
//  Wallet
//
//  Created by Alexandr Sokolov on 18.08.2022.
//

import Foundation
import WalletDesignKit

protocol SetupCategoryPresenterDelegateProtocol: AnyObject {
    func categoryCreated()
}

class SetupCategoryPresenter: SetupCategoryPresenterProtocol {
    
    private var isButtonEnabled: Bool = false
    private let service: SetupCategoryServiceProtocol
    private let router: SetupCategoryRouterProtocol
    private var selectedRowColor: Int = 0
    private var selectedRowCategory: Int = 0
    weak var view: SetupCategoryViewProtocol?
    weak var delegate: SetupCategoryPresenterDelegateProtocol?
    
    init(service: SetupCategoryServiceProtocol, router: SetupCategoryRouterProtocol) {
        self.service = service
        self.router = router
    }
    
    func createButtonDidTap() {
        guard let categoryName = view?.getCategoryName() else { return }
        let iconName = SetupCategoryIconImages.icons[selectedRowCategory]
        let iconColor = SetupCategoryIconColors.colors[selectedRowColor]
        
        let setupCategoryModel = SetupCategoryModel(name: categoryName, iconName: iconName, iconColor: iconColor)
        service.setupCategory(data: setupCategoryModel) { [weak self] result in
            switch result {
            case .success(_):
                self?.delegate?.categoryCreated()
                DispatchQueue.main.async {
                    self?.view?.stopLoading()
                    self?.router.openCategorySelection()
                }
            case .failure(_):
                break
           //     self?.view?.walletCreationFailed(error: error.localizedDescription)
            }
        }
    }
    
    func openCategorySelection() {
        router.openCategorySelection()
    }

    
    func textFieldDidChanchedValue(text: String?) {
        if text != "" {
            isButtonEnabled = true
        } else {
            isButtonEnabled = false
        }
        view?.updateActionButtonState(isActive: isButtonEnabled)
    }
    
    func setSelectedRowColor(row: Int) {
        self.selectedRowColor = row
    }
    
    func setSelectedRowCategory(row: Int) {
        self.selectedRowCategory = row
    }
    
    func getSelectedRowForColor() -> Int {
        selectedRowColor
    }
    
    func getSelectedRowForCategory() -> Int {
        selectedRowCategory
    }
    
    func controllerLoaded() {
        
        //  view?.updateCurrency(currency: currency)
    }
    
}

//extension CreateWalletPresenter: CurrencySelectionDelegateProtocol {
//    func updateSelectedCurrency(currency: Currency) {
//        self.currency = currency
//        view?.updateCurrency(currency: currency)
//    }
//
//    func getSelectedRow() -> Int {
//        return currencySeletedRow ?? 0
//    }
//
//    func saveSelectedRow(row: Int) {
//        currencySeletedRow = row
//    }
//}
