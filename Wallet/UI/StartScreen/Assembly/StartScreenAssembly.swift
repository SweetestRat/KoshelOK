//
//  StartScreenAssembly.swift
//  Wallet
//
//  Created by Владислава Гильде on 12.08.2022.
//

import Foundation
import UIKit

class StartScreenAssembly {
    func assembly() -> UIViewController {
        let model = StartScreenModel()
        let viewController = StartScreenViewController()
        let router = StartScreenRouter(view: viewController)
        let presenter = StartScreenPresenter(model: model, router: router, view: viewController)
        
        viewController.presenter = presenter
        model.presenter = presenter
        
        return viewController
    }
}
