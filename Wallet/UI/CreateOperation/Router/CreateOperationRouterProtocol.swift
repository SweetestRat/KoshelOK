//
//  CreateOperationRouterProtocol.swift
//  Wallet
//
//  Created by Danila on 13.08.2022.
//

import Foundation

protocol CreateOperationRouterProtocol {
    func addOperation()
    func openCurrencySelection(delegate: CurrencySelectionDelegateProtocol)
}