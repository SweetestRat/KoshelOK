//
//  CurrencySelectionPresenterProtocol.swift
//  Wallet
//
//  Created by Владислава Гильде on 12.08.2022.
//

import Foundation

protocol CurrencySelectionPresenterProtocol {
    var delegate: CurrencySelectionDelegateProtocol? { get set }
    
    func getSelectedRow() -> Int?
    func setSelectedRow(row: Int)
    func getNumberOfRows() -> Int?
    func getCurrency(index: Int) -> CurrencyViewModel
    
    func controllerLoaded()
}
