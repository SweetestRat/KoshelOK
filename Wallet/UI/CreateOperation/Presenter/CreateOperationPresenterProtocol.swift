//
//  CreateOperationPresenterProtocol.swift
//  Wallet
//
//  Created by Danila on 13.08.2022.
//

import Foundation

protocol CreateOperationPresenterProtocol: CurrencySeletionDelegateProtocol {
    func viewLoaded()
    
    func selectCategory()
    func selectCurrency()
    func selectDate()
    func selectType()
    func createOperation()
}
