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
    
    func openSetupCategoryScreen() {
        let nextvc = SetupCategoryAssembly().assembly()
        nextvc.modalPresentationStyle = .popover
        view?.navigationController?.present(UINavigationController(rootViewController: nextvc), animated: true, completion: nil)
    }
}
