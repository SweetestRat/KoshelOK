//
//  CurrencySeletionPresenterProtocol.swift
//  Wallet
//
//  Created by Владислава Гильде on 12.08.2022.
//

import Foundation

protocol CurrencySeletionPresenterProtocol {
    func getSelectedRow() -> Int?
    func setSelectedRow(row: Int)
    func controllerLoaded()
}
