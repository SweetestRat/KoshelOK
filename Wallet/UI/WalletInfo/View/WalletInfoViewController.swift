//
//  WalletInfoViewController.swift
//  Wallet
//
//  Created by Владислава Гильде on 13.08.2022.
//

import Foundation
import UIKit

class WalletInfoViewController: UIViewController, WalletInfoViewProtocol {
    private let presenter: WalletInfoPresenterProtocol
    
    init(presenter: WalletInfoPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var walletInfoView: WalletInfoView = {
        let view = WalletInfoView()
        view.delegate = self
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        view.addSubview(walletInfoView)
        walletInfoView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        addTargets()
        setupNavigationBar()
        changeLoadingIndicatorState(state: .loading)
        presenter.controllerLoaded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    private func setupNavigationBar() {
        let walletName = presenter.getWalletName()
        navigationItem.title = walletName
    }
    
    @objc func settingsDidTap() {
        presenter.settingsDidTap()
    }
    
    private func addTargets() {
        walletInfoView.addButtonTarget(self, action: #selector(createOperationButtonDidTap), for: .touchUpInside)
        walletInfoView.addrefreshControllTarget(self, action: #selector(pulledToRefresh), for: .valueChanged)
    }
    
    @objc private func createOperationButtonDidTap() {
        presenter.createOperationButtonDidTap()
    }
    
    @objc private func pulledToRefresh() {
        presenter.controllerLoaded()
    }
    
    func updateOperationsList() {
        walletInfoView.updateOperationsList()
    }
    
    func removeRow(indexPath: IndexPath) {
        walletInfoView.removeRow(indexPath: indexPath)
    }
    
    func removeSection(section: Int) {
        walletInfoView.removeSection(section: section)
    }
    
    func updateBalances(wallet: WalletViewModel) {
        walletInfoView.updateBalances(wallet: wallet)
    }
    
    func loadingError(error: String) {
        // TODO: show error allert
    }
    
    func changeLoadingIndicatorState(state: LoadingIndicatorState) {
        walletInfoView.changeLoadingIndicatorState(state: state)
    }
    
    func changeWalletOperations(isEmpty: Bool) {
        walletInfoView.changeWalletOperations(isEmpty: isEmpty)
    }
}

extension WalletInfoViewController: WalletInfoViewDelegate {
    func getNumberOfSections() -> Int {
        return presenter.getNumberOfSections()
    }
    
    func getOperation(row: Int, section: Int) -> OperationViewModel? {
        return presenter.getOperation(row: row, section: section)
    }
    
    func getNumberOfRowsInSection(section: Int) -> Int? {
        return presenter.getNumberOfRowsInSection(section: section)
    }
    
    func removeOperation(indexPath: IndexPath) {
        exitWaletAlert(title: "Вы уверены, что хотите удалить операцию?", leftButtonTitle: "Да", rightButtonTitle: "Нет") { [weak self] _ in
            self?.presenter.removeOperation(indexPath: indexPath)
        }
    }
}
