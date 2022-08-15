//
//  CurrencySeletionViewController.swift
//  Wallet
//
//  Created by Владислава Гильде on 12.08.2022.
//

import UIKit
import SnapKit

class CurrencySeletionViewController: UIViewController, CurrencySeletionViewProtocol {
    var presenter: CurrencySeletionPresenterProtocol
    
    init(presenter: CurrencySeletionPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var currencySeletionView: CurrencySeletionView = {
        let view = CurrencySeletionView()
        view.delegate = self
        return view
    }()
    
    func updateCurrenciesList(currencies: [Currency]?) {
        currencySeletionView.updateCurrenciesList(currencies: currencies)
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
        view.addSubview(currencySeletionView)
    }
    
    private func setConstraints() {
        currencySeletionView.snp.makeConstraints { make in
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

extension CurrencySeletionViewController: CurrencySeletionViewDelegate {
    func cellSelected(indexPathRow: Int) {
        presenter.setSelectedRow(row: indexPathRow)
    }
    
    func getSelectedRow() -> Int? {
        return presenter.getSelectedRow()
    }
}
