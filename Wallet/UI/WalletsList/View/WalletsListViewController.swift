//
//  WalletsListViewController.swift
//  Wallet
//
//  Created by Danila on 11.08.2022.
//

import UIKit
import SnapKit
import WalletDesignKit

class WalletsListViewController: UIViewController, WalletsListControllerProtocol, WalletsScreenViewDelegate {
    var presenter: WalletsListScreenPresenter?
    
    lazy var screenView: WalletsScreenView = {
        let view = WalletsScreenView()
        view.delegate = self
        return view
    }()
    
    func updateWalletsList(wallets: [Wallet]) {
        screenView.updateWalletsList(wallets: wallets)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(screenView)
        screenView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        presenter?.controller = self
        presenter?.controllerLoaded()
    }
    
    func didTapWallet() {
        presenter?.didTapWallet()
    }
}
