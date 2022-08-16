//
//  CurrencySelectionPresenterProtocol.swift
//  Wallet
//
//  Created by Владислава Гильде on 12.08.2022.
//

import Foundation

protocol CurrencySelectionPresenterProtocol {
    var delegate: CurrencySelectionDelegateProtocol? { get set }
    var currenciesList: [Currency]? { get }
    
    func getSelectedRow() -> Int?
    func setSelectedRow(row: Int)
    func controllerLoaded()
}
