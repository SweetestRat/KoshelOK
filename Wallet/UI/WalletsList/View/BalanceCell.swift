//
//  BalanceCell.swift
//  Wallet
//
//  Created by Владислава Гильде on 18.08.2022.
//

import UIKit
import WalletDesignKit

class BalanceCell: UICollectionViewCell {
    private lazy var commonBalanceValue: UILabel = {
        let view = UILabel()
        view.font = .SFProSemiBold32
        view.textColor = .staticMilkTextColor
        return view
    }()
    
    private lazy var commonIncomeLabel: UIView = BaseDottedText(color: .incomeColor, text: "Общий доход", textFont: .SFProRegular13)
    
    private lazy var commonIncomeValue: UILabel = {
        let view = UILabel()
        view.font = .SFProMedium16
        view.textColor = .staticMilkTextColor
        return view
    }()
    
    private lazy var commonExpansesLabel: UIView = BaseDottedText(color: .designRedColor, text: "Общий расход", textFont: .SFProRegular13)
    
    private lazy var commonExpansesValue: UILabel = {
        let view = UILabel()
        view.font = .SFProMedium16
        view.textColor = .staticMilkTextColor
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        setConstraints()
    }
    
    private func addSubviews() {
        [
            commonBalanceValue,
            commonIncomeLabel,
            commonIncomeValue,
            commonExpansesLabel,
            commonExpansesValue
        ].forEach { self.addSubview($0) }
    }
    
    private func setConstraints() {
        commonBalanceValue.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(MediumPadding)
            make.top.equalToSuperview()
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(balance: CurrencyBalanceViewModel) {
        commonBalanceValue.text = balance.valueToString()
        commonIncomeValue.text = balance.incomeToString()
        commonExpansesValue.text = balance.expanseToString()
    }
}
