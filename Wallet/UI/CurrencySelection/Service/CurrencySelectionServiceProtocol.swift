//
//  CurrencySelectionModelProtocol.swift
//  Wallet
//
//  Created by Владислава Гильде on 12.08.2022.
//

import Foundation

protocol CurrencySelectionServiceProtocol {
    func loadCurrencies(completion: @escaping (Result<[Currency], Error>) -> Void)
    func getCurrencies() -> [Currency]?
}
