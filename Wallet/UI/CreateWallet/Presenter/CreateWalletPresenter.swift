//
//  CreateWalletPresenter.swift
//  Wallet
//
//  Created by Владислава Гильде on 12.08.2022.
//

import UIKit

class CreateWalletPresenter: CreateWalletPresenterProtocol {
    private var isButtonEnabled: Bool = false
    private let service: CreateWalletServiceProtocol
    private let router: CreateWalletRouterProtocol
    weak var view: CreateWalletViewProtocol?
    
    private var currencySeletedRow: Int?
    private var currency: Currency?
    
    init(service: CreateWalletServiceProtocol, router: CreateWalletRouterProtocol) {
        self.service = service
        self.router = router
    }
    
    func createButtonDidTap() {
        guard let walletName = view?.getWalletName(),
              let id = currency?.id else { return }
        
        let createWalletModel = CreateWalletModel(name: walletName, currencyId: id)
        service.createWallet(data: createWalletModel) { [weak self] result in
            switch result {
            case .success(let wallet):
                print(wallet)
                DispatchQueue.main.async {
                    self?.router.openWalletsList()
                }
            case .failure(let error):
                self?.view?.walletCreationFailed(error: error.localizedDescription)
            }
        }
        
        openWalletsList()
    }
    
    func openWalletsList() {
        router.openWalletsList()
    }
    
    func cellCurrencyInfoDidTap() {
        router.openCurrencySelection(delegate: self)
    }
    
    func textFieldDidChanchedValue(text: String?) {
        if text != "" {
            isButtonEnabled = true
        } else {
            isButtonEnabled = false
        }
        view?.updateActionButtonState(isActive: isButtonEnabled)
    }
}

extension CreateWalletPresenter: CurrencySelectionDelegateProtocol {
    func updateSelectedCurrency(currency: Currency) {
        self.currency = currency
        view?.updateCurrency(currency: currency)
    }
    
    func getSelectedRow() -> Int {
        return currencySeletedRow ?? 0
    }
    
    func saveSelectedRow(row: Int) {
        currencySeletedRow = row
    }
}
