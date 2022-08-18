//
//  SetupCategoryRouter.swift
//  Wallet
//
//  Created by Alexandr Sokolov on 18.08.2022.
//

import Foundation
import UIKit

class SetupCategoryRouter: SetupCategoryRouterProtocol {
    weak var view: SetupCategoryViewProtocol?
    
    func openCategorySelection() {
        guard let vc = view as? UIViewController else { return }
        
        vc.navigationController?.dismiss(animated: true)
    }
    
}
