//
//  WalletsListView.swift
//  Wallet
//
//  Created by Danila on 11.08.2022.
//

import UIKit
import WalletDesignKit

class WalletsScreenView: UIView {
    
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
        view.font = .designSFProRegular13
        view.textColor = .lightTextPrimaryColor
        view.alpha = 0.8
        return view
    }()
    
    private lazy var commonBalanceValue: UILabel = {
        let view = UILabel()
        view.text = "9999129 $"
        view.font = .designSFProMedium32
        view.textColor = .lightTextPrimaryColor
        return view
    }()
    
    private lazy var commonIncomeLabel: UIView = dottedText(color: .incomeColor, text: "Общий доход", textFont: .designSFProRegular13)

    private lazy var commonIncomeValue: UILabel = {
        let view = UILabel()
        view.text = "1000062 $"
        view.font = .designSFProMedium16
        view.textColor = .lightTextPrimaryColor
        return view
    }()
    
    private lazy var commonExpansesLabel: UIView = dottedText(color: .designRedColor, text: "Общий расход", textFont: .designSFProRegular13)
    
    private lazy var commonExpansesValue: UILabel = {
        let view = UILabel()
        view.text = "-1001 $"
        view.font = .designSFProMedium16
        view.textColor = .lightTextPrimaryColor
        return view
    }()
    
    private func dottedText(color: UIColor?, text: String, textFont: UIFont) -> UIView {
        let view = UIView()
        let dot = UIView()
        let textView = UILabel()
        
        dot.backgroundColor = color
        dot.layer.cornerCurve = .continuous
        dot.layer.cornerRadius = CGFloat(SmallPadding) / 4
        
        textView.textColor = .lightTextPrimaryColor
        textView.text = text
        textView.font = textFont
        textView.alpha = 0.8
        
        view.addSubview(dot)
        view.addSubview(textView)
        
        dot.snp.makeConstraints { make in
            make.leading.centerY.equalToSuperview()
            make.size.equalTo(SmallPadding)
        }
        
        textView.snp.makeConstraints { make in
            make.leading.equalTo(dot.snp.trailing).offset(SmallPadding)
        }
        
        view.snp.makeConstraints { make in
            make.trailing.equalTo(textView.snp.trailing)
            make.top.bottom.equalTo(textView)
        }
        
        return view
    }

    init() {
        super.init(frame: .zero)
        backgroundColor = .background
        
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        [
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
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(LargePadding * 2)
        }
        
        commonBalanceValue.snp.makeConstraints { make in
            make.leading.equalTo(commonBalanceLabel.snp.leading)
            make.top.equalTo(commonBalanceLabel.snp.bottom).offset(SmallPadding)
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
    }
}
