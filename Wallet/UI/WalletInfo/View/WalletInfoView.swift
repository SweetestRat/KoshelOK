//
//  WalletInfoView.swift
//  Wallet
//
//  Created by Владислава Гильде on 13.08.2022.
//

import Foundation
import UIKit
import WalletDesignKit

class WalletInfoView: UIView {
    private var walletInfo: [WalletViewModel]?
    
    private lazy var walletCardView: UIView = {
        let view = UIView()
        view.backgroundColor = .activeButtonBackground
        view.layer.cornerCurve = .continuous
        view.layer.cornerRadius = CGFloat(MediumPadding)
        return view
    }()
    
    private lazy var walletNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Кошелек 1"
        label.font = .SFProMedium16
        label.textColor = .lightTextPrimaryColor
        label.alpha = 0.8
        return label
    }()
    
    private lazy var commonBalanceValue: UILabel = {
        let label = UILabel()
        label.text = "118 000 $"
        label.font = .SFProSemiBold32
        label.textColor = .lightTextPrimaryColor
        return label
    }()
    
    private lazy var commonIncomeLabel: UIView = BaseDottedText(color: .incomeColor, text: "Общий доход", textFont: .SFProRegular13)
    
    private lazy var commonIncomeValue: UILabel = {
        let label = UILabel()
        label.text = "130 000 $"
        label.font = .SFProMedium16
        label.textColor = .lightTextPrimaryColor
        return label
    }()
    
    private lazy var commonExpansesLabel: UIView = BaseDottedText(color: .designRedColor, text: "Общий расход", textFont: .SFProRegular13)
    
    private lazy var commonExpansesValue: UILabel = {
        let label = UILabel()
        label.text = "12 000 $"
        label.font = .SFProMedium16
        label.textColor = .lightTextPrimaryColor
        return label
    }()
    
    private lazy var walletsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(WalletInfoCell.self, forCellReuseIdentifier: "WalletInfoCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = nil
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.contentInset = UIEdgeInsets(top: CGFloat(MediumPadding), left: 0, bottom: 0, right: 0)
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private lazy var actionButton: BaseButton = {
        let button = BaseButton(title: "Создать операцию")
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        walletInfo = Array(repeating:
                        WalletViewModel(name: "Wallet Name",
                                        icon: "",
                                        balance:
                                            BalanceViewModel(value: 125,
                                                             currency:
                                                                CurrencyViewModel(symbol: "RUB",
                                                                                  fullName: "Russian"))), count: 12)
        
        walletsTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)

        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        [
            walletsTableView,
            actionButton,
            walletCardView
        ].forEach { addSubview($0) }
        [
            walletNameLabel,
            commonBalanceValue,
            commonIncomeLabel,
            commonIncomeValue,
            commonExpansesLabel,
            commonExpansesValue
        ].forEach { walletCardView.addSubview($0) }
    }
    
    private func setConstraints() {
        walletCardView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(MediumPadding)
            make.leading.trailing.equalToSuperview().inset(MediumPadding)
            make.bottom.equalTo(commonIncomeValue.snp.bottom).offset(LargePadding)
        }
        
        walletsTableView.snp.makeConstraints { make in
            make.top.equalTo(walletCardView.snp.bottom).offset(-MediumPadding)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(actionButton.snp.centerY)
        }
        
        actionButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(MediumPadding)
            make.height.equalTo(ActionButtonHeight)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(MediumPadding)
        }
        
        walletNameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(MediumPadding)
            make.top.equalToSuperview().offset(MediumPadding)
        }
        
        commonBalanceValue.snp.makeConstraints { make in
            make.top.equalTo(walletNameLabel.snp.bottom)
            make.leading.equalTo(walletNameLabel.snp.leading)
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
    }
    
    public func addButtonTarget(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) {
        actionButton.addTarget(target, action: action, for: controlEvents)
    }
}

extension WalletInfoView: UITableViewDelegate {
    
}

extension WalletInfoView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WalletInfoCell", for: indexPath) as? WalletInfoCell else {
            return WalletInfoCell()
        }
        
        cell.title.text = walletInfo?[indexPath.row].name
        cell.balance.text = walletInfo?[indexPath.row].balance.toString()
        cell.backgroundColor = .background
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(TableViewCellHeight)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Сегодня"
        } else {
            return "Вчера"
        }
    }
}
