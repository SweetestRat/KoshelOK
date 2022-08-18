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
        
        time.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
        }
    }
    
    func configurate(operation: OperationViewModel) {
        category.text = operation.category.name
        balance.text = operation.isIncome ? operation.balance.toString() : "-\(operation.balance.toString())"
        balance.textColor = operation.isIncome ? UIColor.incomeColor : UIColor.designRedColor
        
        let color = operation.category.iconColor
        let imageName = operation.category.iconName
        icon.backgroundColor = UIColor(hex: color)
        let config = UIImage.SymbolConfiguration(scale: .large)
        let image = UIImageView(image: UIImage(systemName: imageName, withConfiguration: config))
        image.tintColor = .lightTextPrimaryColor
        icon.addSubview(image)
        
        icon.layer.cornerRadius = CGFloat(IconSize / 2)
        
        image.snp.makeConstraints {make in
            make.center.equalToSuperview()
        }
        backgroundColor = .background
    }
}
