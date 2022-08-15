//
//  CreateOperationViewProtocol.swift
//  Wallet
//
//  Created by Danila on 13.08.2022.
//

import Foundation

protocol CreateOperationViewProtocol: AnyObject {
    var presenter: CreateOperationPresenterProtocol? { get }
    func updateCurrency(currency: Currency)
}
