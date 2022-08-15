//
//  CreateOperationRouter.swift
//  Wallet
//
//  Created by Danila on 13.08.2022.
//

import Foundation
import UIKit

class CreateOperationRouter: CreateOperationRouterProtocol {
    weak var view: CreateOperationViewProtocol?
    
    init(view: CreateOperationViewController) {
        self.view = view
    }
    
    func addOperation() {
        guard let vc = view as? UIViewController else { return }
        
        vc.navigationController?.popViewController(animated: true)
    }
    
    func openCurrencySelection() {
        let nextvc = CurrencySelectionAssembly().assembly()
        nextvc.presenter.delegate = view?.presenter
        guard let vc = view as? UIViewController else { return }
        
        vc.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        vc.navigationController?.pushViewController(nextvc, animated: true)
    }
}
