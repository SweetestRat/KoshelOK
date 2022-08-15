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
        let service = StartScreenService()
        let router = StartScreenRouter()
        let presenter = StartScreenPresenter(service: service, router: router)
        let viewController = StartScreenViewController(presenter: presenter)
        
        presenter.view = viewController
        router.view = viewController
        
        return viewController
    }
}
