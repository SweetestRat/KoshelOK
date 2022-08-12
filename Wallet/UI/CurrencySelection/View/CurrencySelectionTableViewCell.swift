//
//  CurrencySelectionTableViewCell.swift
//  Wallet
//
//  Created by Владислава Гильде on 12.08.2022.
//

import UIKit
import SnapKit
import WalletDesignKit

class CurrencySelectionTableViewCell: UITableViewCell {
    private(set) lazy var title: UILabel = {
        let label = UILabel()
        label.font = .designSFProRegular17
        label.textColor = .darkTextPrimaryColor
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .background
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func addSubviews() {
        addSubview(title)
    }
    
    private func setConstraints() {
        title.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(MediumPadding)
            make.centerY.equalToSuperview()
        }
    }
}
