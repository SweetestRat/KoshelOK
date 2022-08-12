//
//  CreateWalletViewController.swift
//  Wallet
//
//  Created by Владислава Гильде on 11.08.2022.
//

import UIKit

class CreateWalletViewController: UIViewController, CreateWalletViewProtocol {
    var presenter: CreateWalletPresenterProtocol?
    
    private lazy var createWalletView: CreateWalletView = {
        let view = CreateWalletView()
        view.delegate = self
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setNavigationBar()
    }
    
    private func setup() {
        self.view.addSubview(createWalletView)
        
        createWalletView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        createWalletView.addButtonTarget(self, action: #selector(openWalletsList), for: .touchUpInside)
    }
    
    private func setNavigationBar() {
        navigationItem.title = "Создание кошелька"
    }
    
    @objc private func openWalletsList() {
        presenter?.createWallet()
    }
}

extension CreateWalletViewController: CreateWalletViewDelegate {
    func cellCurrencyInfoDidTap() {
        presenter?.cellCurrencyInfoDidTap()
    }
}
