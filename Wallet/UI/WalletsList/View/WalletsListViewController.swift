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
    
    func updateWalletsList() {
        screenView.updateWalletsList()
    }
    
    func updateBalances(commonBalance: BalanceViewModel?, income: BalanceViewModel?, expanse: BalanceViewModel?) {
        screenView.updateBalances(commonBalance: commonBalance, income: income, expanse: expanse)
    }
    
    func changeWalletsList(isEmpty: Bool) {
        screenView.changeWalletsList(isEmpty: isEmpty)
    }
    
    func walletsLoadingError(error: String) {
        
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
        
        addTargets()
        setupNavigationBar()
        changeLoadingIndicatorState(state: .loading)
        presenter.controllerLoaded()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Кошельки"
    }
    
    private func addTargets() {
        screenView.addActionButtonTarget(self, action: #selector(screenViewButtonDidTap), for: .touchUpInside)
        screenView.addExitButtonTarget(self, action: #selector(screenViewExitButtonDidTap), for: .touchUpInside)
        screenView.addrefreshControllTarget(self, action: #selector(pulledToRefresh), for: .valueChanged)
    }
    
    func changeLoadingIndicatorState(state: LoadingIndicatorState) {
        screenView.changeLoadingIndicatorState(state: state)
    }
    
    @objc private func pulledToRefresh() {
        presenter.controllerLoaded()
    }
    
    @objc private func screenViewButtonDidTap() {
        presenter.createWalletClicked()
    }
    
    @objc private func screenViewExitButtonDidTap() {
        
        exitWaletAlert { [weak self] _ in
            self?.presenter.createExitFromWallet()
        }
    }
}

extension WalletsListViewController: WalletsScreenViewDelegate {
    func getBalance(row: Int) -> CurrencyBalanceViewModel? {
        presenter.getBalance(row: row)
    }
    
    func getNumberOfBalanceRows() -> Int? {
        presenter.getNumberOfBalanceRows()
    }
    
    func didTapWallet(at row: Int) {
        presenter.didTapWallet(at: row)
    }
    
    func getWallet(at row: Int) -> WalletViewModel? {
        presenter.getWallet(at: row)
    }
    
    func getNumberOfRows() -> Int {
        presenter.getNumberOfRows()
    }
    
}
