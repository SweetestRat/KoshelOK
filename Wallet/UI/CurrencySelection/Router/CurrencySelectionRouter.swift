//
//  CurrencySelectionRouter.swift
//  Wallet
//
//  Created by Владислава Гильде on 12.08.2022.
//

import Foundation 

class CurrencySelectionRouter: CurrencySelectionRouterProtocol {
    var view: CurrencySelectionViewProtocol?
    
    init(view: CurrencySelectionViewProtocol) {
        self.view = view
    }
}
