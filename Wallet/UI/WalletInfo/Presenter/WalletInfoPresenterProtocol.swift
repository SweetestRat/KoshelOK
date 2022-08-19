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
    func getNumberOfRowsInSection(section: Int) -> Int?
    func getNumberOfSections() -> Int
    func controllerLoaded()
    func getWalletName() -> String
    func removeOperation(indexPath: IndexPath)
}
