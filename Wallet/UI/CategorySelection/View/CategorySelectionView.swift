//
//  CategorySelectionView.swift
//  Wallet
//
//  Created by Alexandr Sokolov on 14.08.2022.
//

import UIKit
import WalletDesignKit

protocol CategorySelectionViewDelegate: AnyObject {
    func cellSelected(indexPathRow: Int)
    func getSelectedRow() -> Int?
    func getNumberOfRows() -> Int?
    func getCategory(index: Int) -> Category
}

class CategorySelectionView: UIView {
    weak var delegate: CategorySelectionViewDelegate?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .background
        return tableView
    }()
    
    private lazy var actionButton: BaseButton = {
        let button = BaseButton(title: "Выбрать")
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        addSubviews()
        setConstraints()
        setupTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(tableView)
        addSubview(actionButton)
    }
    
    private func setConstraints() {
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.leading.trailing.equalTo(self)
            make.bottom.equalTo(actionButton.snp.top).offset(MediumPadding)
        }
        
        actionButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(MediumPadding)
            make.height.equalTo(ActionButtonHeight)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    private func setupTableView() {
        tableView.register(CategorySelectionTableViewCell.self, forCellReuseIdentifier: "CategorySelectionTableViewCell")
    }
}

extension CategorySelectionView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(TableViewCellHeight)
    }
}

extension CategorySelectionView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        delegate?.getNumberOfRows() ?? 0
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CategorySelectionTableViewCell", for: indexPath) as? CategorySelectionTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configurate(parametres: self.delegate?.getCategory(index: indexPath.row) ?? Category(id: indexPath.row, name: "", iconName: "sun.,ax.fill", iconColor: "7765C0"))
    
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
