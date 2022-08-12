//
//  WalletsListCell.swift
//  Wallet
//
//  Created by Danila on 12.08.2022.
//

import UIKit
import SnapKit
import WalletDesignKit

class WalletsListCell: UITableViewCell {
    
    lazy var icon: UIView = {
        let view = UIView()
        view.layer.cornerRadius = CGFloat(IconSize / 2)
        view.backgroundColor = .systemGray
        return view
    }()
    
    lazy var title: UILabel = {
        let view = UILabel()
        view.font = .designSFProRegular17
        return view
    }()
    
    lazy var balance: UILabel = {
        let view = UILabel()
        view.font = .designSFProRegular17
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        [icon, title, balance].forEach {
            contentView.addSubview($0)
        }
        
        icon.snp.makeConstraints { make in
            make.size.equalTo(IconSize)
            make.centerY.equalToSuperview()
            make.leading.equalTo(contentView).inset(MediumPadding)
        }
        
        title.snp.makeConstraints { make in
            make.leading.equalTo(icon.snp.trailing).offset(MediumPadding)
            make.centerY.equalToSuperview()
        }
        
        balance.snp.makeConstraints { make in
            make.trailing.equalTo(contentView.snp.trailing).inset(MediumPadding)
            make.centerY.equalToSuperview()
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
