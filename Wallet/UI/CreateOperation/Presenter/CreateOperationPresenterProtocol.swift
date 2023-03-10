//
//  CreateOperationPresenterProtocol.swift
//  Wallet
//
//  Created by Danila on 13.08.2022.
//

import Foundation

protocol CreateOperationPresenterProtocol: CurrencySelectionDelegateProtocol {
    func viewLoaded()
    
    func selectCategory()
    func selectCurrency()
    func selectDate()
    func dateDidChanged(date: Date)
    func createDidTap()
    func amountDidChange(amount: String)
    func incomeDidSelected()
    func expanseDidSelected()
    func getMaxAmountValue() -> Double
}
