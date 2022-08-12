//
//  CurrencySeletionRouter.swift
//  Wallet
//
//  Created by Владислава Гильде on 12.08.2022.
//

import Foundation 

class CurrencySeletionRouter: CurrencySeletionRouterProtocol {
    var view: CurrencySeletionViewProtocol?
    
    init(view: CurrencySeletionViewProtocol) {
        self.view = view
    }
}
