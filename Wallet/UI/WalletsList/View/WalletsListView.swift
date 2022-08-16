//
//  WalletsListView.swift
//  Wallet
//
//  Created by Danila on 11.08.2022.
//

import UIKit
import WalletDesignKit

protocol WalletsScreenViewDelegate: AnyObject {
    func didTapWallet()
}

class WalletsScreenView: UIView {
    weak var delegate: WalletsScreenViewDelegate?
    private var walletsList: [WalletViewModel]?
    
    private lazy var actionButton: BaseButton = {
        let button = BaseButton(title: "Создать кошелёк")
        return button
    }()
    
    private lazy var headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .activeButtonBackground
        view.layer.cornerCurve = .continuous
        view.layer.cornerRadius = CGFloat(MediumPadding)
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        return view
    }()
    
    private lazy var commonBalanceLabel: UILabel = {
        let view = UILabel()
        view.text = "Общий баланс"
        view.font = .SFProMedium16
        view.textColor = .lightTextPrimaryColor
        view.alpha = 0.8
        return view
    }()
    
    private lazy var commonBalanceValue: UILabel = {
        let view = UILabel()
        view.text = "9 999 129 $"
        view.font = .SFProSemiBold32
        view.textColor = .lightTextPrimaryColor
        return view
    }()
    
    private lazy var commonIncomeLabel: UIView = BaseDottedText(color: .incomeColor, text: "Общий доход", textFont: .SFProRegular13)
    
    private lazy var commonIncomeValue: UILabel = {
        let view = UILabel()
        view.text = "1 000 062 $"
        view.font = .SFProMedium16
        view.textColor = .lightTextPrimaryColor
        return view
    }()
    
    private lazy var commonExpansesLabel: UIView = BaseDottedText(color: .designRedColor, text: "Общий расход", textFont: .SFProRegular13)
    
    private lazy var commonExpansesValue: UILabel = {
        let view = UILabel()
        view.text = "-1 001 $"
        view.font = .SFProMedium16
        view.textColor = .lightTextPrimaryColor
        return view
    }()
    
    private lazy var walletsListView: UITableView = {
        let view = UITableView()
        view.register(WalletsListCell.self, forCellReuseIdentifier: "WalletsListCell")
        view.dataSource = self
        view.delegate = self
        view.backgroundColor = nil
        return view
    }()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .background
        
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateWalletsList(wallets: [WalletViewModel]) {
        update(list: wallets)
        walletsListView.reloadData()
    }
    
    private func addSubviews() {
        [
            walletsListView,
            actionButton,
            headerView
        ].forEach { self.addSubview($0) }
        
        [
            commonIncomeValue,
            commonIncomeLabel,
            commonBalanceValue,
            commonBalanceLabel,
            commonExpansesLabel,
            commonExpansesValue
        ].forEach { headerView.addSubview($0) }

    }
    
    private func setConstraints() {
        actionButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(MediumPadding)
            make.height.equalTo(ActionButtonHeight)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(MediumPadding)
        }
        
        commonBalanceLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(MediumPadding)
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(LargePadding)
        }
        
        commonBalanceValue.snp.makeConstraints { make in
            make.leading.equalTo(commonBalanceLabel.snp.leading)
            make.top.equalTo(commonBalanceLabel.snp.bottom)

        }
        
        commonIncomeLabel.snp.makeConstraints { make in
            make.top.equalTo(commonBalanceValue.snp.bottom).offset(LargePadding)
            make.leading.equalTo(commonBalanceValue.snp.leading)
        }
        
        commonIncomeValue.snp.makeConstraints { make in
            make.top.equalTo(commonIncomeLabel.snp.bottom).offset(SmallPadding)
            make.leading.equalTo(commonIncomeLabel.snp.leading)
        }
        
        commonExpansesLabel.snp.makeConstraints { make in
            make.top.equalTo(commonBalanceValue.snp.bottom).offset(LargePadding)
            make.leading.equalTo(snp.centerX)
        }
        
        commonExpansesValue.snp.makeConstraints { make in
            make.top.equalTo(commonExpansesLabel.snp.bottom).offset(SmallPadding)
            make.leading.equalTo(commonExpansesLabel.snp.leading)
        }
        
        headerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalTo(commonIncomeValue.snp.bottom).offset(MediumPadding)
        }
        
        walletsListView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.leading.trailing.equalTo(self)
            make.bottom.equalTo(actionButton.snp.top).offset(MediumPadding)
        }
    }
    
    func addButtonTarget(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) {
        actionButton.addTarget(target, action: action, for: controlEvents)
    }
}

extension WalletsScreenView: UITableViewDataSource, UITableViewDelegate {
    
    public func update(list: [WalletViewModel]) {
        walletsList = list
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didTapWallet()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        CGFloat(TableViewCellHeight)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        walletsList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WalletsListCell", for: indexPath) as? WalletsListCell else {
            return WalletsListCell()
        }
        cell.title.text = walletsList?[indexPath.row].name
        cell.balance.text = walletsList?[indexPath.row].balance.toString()
        cell.backgroundColor = .background
        
        return cell
    }
    
}
