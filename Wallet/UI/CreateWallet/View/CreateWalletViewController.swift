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
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    private func setup() {
        self.view.addSubview(createWalletView)
        
        createWalletView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        createWalletView.addButtonTarget(self, action: #selector(openWalletsList), for: .touchUpInside)
    }
    
    @objc private func openWalletsList() {
        presenter?.createWallet()
    }
}
