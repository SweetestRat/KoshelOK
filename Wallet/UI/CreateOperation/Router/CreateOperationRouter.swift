//
//  CreateOperationRouter.swift
//  Wallet
//
//  Created by Danila on 13.08.2022.
//

import Foundation
import UIKit

class CreateOperationRouter: CreateOperationRouterProtocol {
    weak var view: UIViewController?
    
    func addOperation() {
        view?.navigationController?.popViewController(animated: true)
    }
    
    func openCurrencySelection(delegate: CurrencySelectionDelegateProtocol) {
        let nextvc = CurrencySelectionAssembly().assembly(delegate: delegate)
        
        view?.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        view?.navigationController?.pushViewController(nextvc, animated: true)
    }
    
    func openDateSelection(delegate: DatePickerDelegateProtocol, currentDate: Date) {
        let nextvc = DatePickerAssembly().assembly(delegate: delegate, date: currentDate)
        nextvc.modalPresentationStyle = .popover
        view?.navigationController?.present(UINavigationController(rootViewController: nextvc), animated: true, completion: nil)
    }
    
    func openCategorySelection(delegate: CategorySelectionDelegateProtocol, currentCategory: Category) {
        let nextvc = CategorySelectionAssembly().assembly(delegate: delegate, category: currentCategory)
        nextvc.modalPresentationStyle = .popover
        view?.navigationController?.present(UINavigationController(rootViewController: nextvc), animated: true, completion: nil)
    }
}
