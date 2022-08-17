//
//  CreateOperationViewProtocol.swift
//  Wallet
//
//  Created by Danila on 13.08.2022.
//

import Foundation

protocol CreateOperationViewProtocol: AnyObject {
    func updateCurrency(currency: CurrencyViewModel)
    func updateDate(date: Date)
    func updateCategory(category: CategoryViewModel)
}
