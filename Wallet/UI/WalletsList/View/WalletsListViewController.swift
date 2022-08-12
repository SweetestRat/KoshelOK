//
//  WalletsListViewController.swift
//  Wallet
//
//  Created by Danila on 11.08.2022.
//

import UIKit
import SnapKit
import WalletDesignKit

class WalletsListViewController: UIViewController, WalletsListControllerProtocol {
    var presenter = WalletsListScreenPresenter()
    
    lazy var screenView: WalletsScreenView = {
        WalletsScreenView()
    }()
    
    func updateWalletsList(wallets: [Wallet]) {
        screenView.updateWalletsList(wallets: wallets)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(screenView)
        screenView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        presenter.controller = self
        presenter.controllerLoaded()
    }
}
