//
//  WalletInfoPresenterProtocol.swift
//  Wallet
//
//  Created by Владислава Гильде on 13.08.2022.
//

import Foundation

protocol WalletInfoPresenterProtocol: AnyObject {
    func settingsDidTap()
    func createOperationButtonDidTap()
    func getOperation(row: Int, section: Int) -> OperationViewModel?
    func getNumberOfRows() -> Int
    func getNumberOfRowsInSection(section: Int) -> Int?
}
