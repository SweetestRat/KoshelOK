//
//  WalletInfoCell.swift
//  Wallet
//
//  Created by Владислава Гильде on 13.08.2022.
//

import Foundation
import UIKit
import WalletDesignKit

class WalletInfoCell: UITableViewCell {
    var icon: UIView = {
        let view = UIView()
        view.layer.cornerRadius = CGFloat(IconSize / 2)
        return view
    }()
    
    lazy var category: UILabel = {
        let label = UILabel()
        label.font = .SFProRegular16
        label.textColor = .darkTextPrimaryColor
        return label
    }()
    
    lazy var infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = CGFloat(ExtraSmallPadding)
        return stackView
    }()

    lazy var balance: UILabel = {
        let label = UILabel()
        label.font = .SFProRegular16
        label.text = "130 000 $"
        label.textColor = .incomeColor
        return label
    }()
    
    lazy var time: UILabel = {
        let label = UILabel()
        label.font = .SFProRegular16
        label.text = "15:00"
        label.textColor = .inputPlaceholderColor
        label.textAlignment = .right
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubviews()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        [
            icon,
            category,
            infoStackView
        ].forEach { addSubview($0) }
        [
            balance,
            time
        ].forEach { infoStackView.addArrangedSubview($0) }
    }
    
    private func setConstraints() {
        icon.snp.makeConstraints { make in
            make.size.equalTo(IconSize)
            make.centerY.equalToSuperview()
            make.leading.equalTo(contentView).inset(MediumPadding)
        }
        
        category.snp.makeConstraints { make in
            make.leading.equalTo(icon.snp.trailing).offset(SmallPadding)
            make.centerY.equalToSuperview()
            make.trailing.equalTo(infoStackView.snp.leading).offset(-SmallPadding)
        }
        
        infoStackView.snp.makeConstraints { make in
            make.trailing.equalTo(contentView.snp.trailing).inset(MediumPadding)
            make.centerY.equalToSuperview()
        }
        
    }
}
