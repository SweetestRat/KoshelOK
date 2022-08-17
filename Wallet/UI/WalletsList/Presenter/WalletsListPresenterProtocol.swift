//
//  WalletsListPresenterProtocol.swift
//  Wallet
//
//  Created by Danila on 12.08.2022.
//

protocol WalletsListPresenterProtocol: AnyObject {
    func createWalletClicked()
    func didTapWallet(at row: Int)
    func controllerLoaded()
    func getWallet(at row: Int) -> WalletViewModel?
    func getNumberOfRows() -> Int
}
