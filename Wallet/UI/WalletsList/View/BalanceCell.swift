//
//  BalanceCell.swift
//  Wallet
//
//  Created by Владислава Гильде on 18.08.2022.
//

import UIKit
import WalletDesignKit

class BalanceCell: UICollectionViewCell {
    lazy var currencyBalance: UILabel = {
        let label = UILabel()
        label.font = .SFProSemiBold32
        label.textColor = .lightTextPrimaryColor
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(currencyBalance)
        
        currencyBalance.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(MediumPadding)
            make.centerY.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
