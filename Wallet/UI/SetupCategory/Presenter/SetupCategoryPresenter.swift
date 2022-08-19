//
//  SetupCategoryPresenter.swift
//  Wallet
//
//  Created by Alexandr Sokolov on 18.08.2022.
//

import Foundation
import WalletDesignKit

protocol SetupCategoryPresenterDelegateProtocol: AnyObject {
    func categoryCreated(category: Category)
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
        view?.updateActionButtonState(actionState: .loading)
        service.setupCategory(data: setupCategoryModel) { [weak self] result in
            switch result {
            case .success(let category):
                self?.delegate?.categoryCreated(category: category)
                DispatchQueue.main.async {
                    self?.view?.updateActionButtonState(actionState: .inactive)
                    self?.router.openCategorySelection()
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self?.view?.updateActionButtonState(actionState: .active)
                }
                break
            }
        }
    }
    
    func openCategorySelection() {
        router.openCategorySelection()
    }

    
    func textFieldDidChanchedValue(text: String?) {
        if text != "" {
            view?.updateActionButtonState(actionState: .active)
        } else {
            view?.updateActionButtonState(actionState: .inactive)
        }
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
}
