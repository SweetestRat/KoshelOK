//
//  CreateOperationViewProtocol.swift
//  Wallet
//
//  Created by Danila on 13.08.2022.
//

import Foundation
import WalletDesignKit

protocol CreateOperationViewProtocol: AnyObject {
    func updateCurrency(currency: Currency)
    func updateDate(date: Date)
    func updateOperationType(operationType: OperationType)
    func updateCategory(category: CategoryViewModel)
    func updateActionButtonState(state: BaseButtonState)
}
