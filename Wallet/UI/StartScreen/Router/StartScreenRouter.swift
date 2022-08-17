//
//  StartScreenRouter.swift
//  Wallet
//
//  Created by Владислава Гильде on 12.08.2022.
//

import UIKit

class StartScreenRouter: StartScreenRouterProtocol {
    weak var view: StartScreenViewProtocol?
    
    func openAuthorization() {
        let nextvc = AuthorizationAsembly().assembly()
        guard let vc = view as? UIViewController else { return }
        
        vc.navigationController?.setViewControllers([nextvc], animated: true)
    }
}
