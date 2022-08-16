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
    
    func back() {
        view?.navigationController?.dismiss(animated: true)
    }
}
