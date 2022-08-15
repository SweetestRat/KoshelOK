//
//  CurrencySeletionView.swift
//  Wallet
//
//  Created by Владислава Гильде on 12.08.2022.
//

import UIKit
import WalletDesignKit

protocol CurrencySeletionViewDelegate: AnyObject {
    func cellSelected(indexPathRow: Int)
    func getSelectedRow() -> Int?
}

class CurrencySeletionView: UIView {
    weak var delegate: CurrencySeletionViewDelegate?
    private var currenciesList: [Currency]?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .background
        return tableView
    }()
    
    func updateCurrenciesList(currencies: [Currency]?) {
        currenciesList = currencies ?? Array()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        addSubviews()
        setConstraints()
        setupTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(tableView)
    }
    
    private func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
    
    private func setupTableView() {
        tableView.register(CurrencySelectionTableViewCell.self, forCellReuseIdentifier: "CurrencySelectionTableViewCell")
    }
}

extension CurrencySeletionView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(TableViewCellHeight)
    }
}

extension CurrencySeletionView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        currenciesList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let row = delegate?.getSelectedRow() else { return }
        tableView.deselectRow(at: IndexPath(row: row, section: 0), animated: false)
        let previousCell = tableView.cellForRow(at: IndexPath(row: row, section: 0))
        previousCell?.accessoryType = .none
        
        delegate?.cellSelected(indexPathRow: indexPath.row)
        tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        let currentCell = tableView.cellForRow(at: indexPath)
        currentCell?.accessoryType = .checkmark
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencySelectionTableViewCell", for: indexPath) as? CurrencySelectionTableViewCell else {
            return UITableViewCell()
        }
        guard let currency = currenciesList?[indexPath.row] else { return UITableViewCell() }
        
        cell.title.text = currency.fullName
        let row = delegate?.getSelectedRow()

        if indexPath.row == row {
            cell.accessoryType = .checkmark
            delegate?.cellSelected(indexPathRow: indexPath.row)
        } else {
            cell.accessoryType = .none
        }
        
        cell.selectionStyle = .none
        
        return cell
    }
}
