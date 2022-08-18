//
//  CategorySelectionRouter.swift
//  Wallet
//
//  Created by Alexandr Sokolov on 16.08.2022.
//

import Foundation
import UIKit

class CategorySelectionRouter: CategorySelectionRouterProtocol {
    weak var view: UIViewController?
    
    func closeCAtegorySelectionScreen() {
        view?.navigationController?.dismiss(animated: true)
    }
    
    func openSetupCategoryScreen(delegate: SetupCategoryPresenterDelegateProtocol) {
        let nextvc = SetupCategoryAssembly().assembly(delegate: delegate)
        view?.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        view?.navigationController?.pushViewController(nextvc, animated: true)
    }
}
