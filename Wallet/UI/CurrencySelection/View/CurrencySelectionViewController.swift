//
//  CurrencySelectionViewController.swift
//  Wallet
//
//  Created by Владислава Гильде on 12.08.2022.
//

import UIKit
import SnapKit

class CurrencySelectionViewController: UIViewController, CurrencySelectionViewProtocol {
    var presenter: CurrencySelectionPresenterProtocol?
    
    private lazy var currencySelectionView: CurrencySelectionView = {
        let view = CurrencySelectionView()
        view.delegate = self
        return view
    }()
    
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
        presenter?.controllerLoaded()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Выбор валюты"
    }
}

extension CurrencySelectionViewController: CurrencySelectionViewDelegate {
    func cellSelected(indexPathRow: Int) {
        presenter?.setSelectedRow(row: indexPathRow)
    }
    
    func getSelectedRow() -> Int? {
        return presenter?.getSelectedRow()
    }
}
