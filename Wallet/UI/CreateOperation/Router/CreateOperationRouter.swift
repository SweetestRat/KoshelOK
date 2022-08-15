//
//  CreateOperationRouter.swift
//  Wallet
//
//  Created by Danila on 13.08.2022.
//

import Foundation
import UIKit

class CreateOperationRouter: CreateOperationRouterProtocol {
    var view: CreateOperationViewProtocol?
    
    init(view: CreateOperationViewController) {
        self.view = view
    }
    
    func addOperation() {
        guard let vc = view as? UIViewController else { return }
        
        vc.navigationController?.popViewController(animated: true)
    }
    
    func openCurrencySelection() {
        let nextvc = CurrencySelectionAssembly().configureViewController()
        nextvc.presenter?.delegate = view?.presenter
        guard let vc = view as? UIViewController else { return }
        
        vc.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        vc.navigationController?.pushViewController(nextvc, animated: true)
    }
}
