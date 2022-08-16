//
//  CurrencySelectionViewController.swift
//  Wallet
//
//  Created by Владислава Гильде on 12.08.2022.
//

import UIKit
import SnapKit

class CurrencySelectionViewController: UIViewController, CurrencySelectionViewProtocol {
    private let presenter: CurrencySelectionPresenterProtocol
    
    init(presenter: CurrencySelectionPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var currencySelectionView: CurrencySelectionView = {
        let view = CurrencySelectionView()
        view.delegate = self
        return view
    }()
    
    func updateCurrenciesList(currencies: [CurrencyViewModel]?) {
        currencySelectionView.updateCurrenciesList(currencies: currencies)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        
        getData()
        setupNavigationBar()
        addSubviews()
        setConstraints()
    }
    
    private func addSubviews() {
        view.addSubview(currencySelectionView)
    }
    
    private func setConstraints() {
        currencySelectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func getData() {
        presenter.controllerLoaded()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Выбор валюты"
    }
}

extension CurrencySelectionViewController: CurrencySelectionViewDelegate {
    func cellSelected(indexPathRow: Int) {
        presenter.setSelectedRow(row: indexPathRow)
    }
    
    func getSelectedRow() -> Int? {
        return presenter.getSelectedRow()
    }
}
