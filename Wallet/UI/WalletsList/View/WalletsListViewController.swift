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
    private let presenter: WalletsListPresenterProtocol
    
    init(presenter: WalletsListPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var screenView: WalletsScreenView = {
        let view = WalletsScreenView()
        view.delegate = self
        return view
    }()
    
    func updateWalletsList(wallets: [WalletViewModel]) {
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
        presenter.controllerLoaded()
        addTargets()
    }
    
    func didTapWallet() {
        presenter.didTapWallet()
    }
    
    private func addTargets() {
        screenView.addButtonTarget(self, action: #selector(screenViewButtonDidTap), for: .touchUpInside)
    }
    
    @objc private func screenViewButtonDidTap() {
        presenter.createWalletClicked()
    }
}
