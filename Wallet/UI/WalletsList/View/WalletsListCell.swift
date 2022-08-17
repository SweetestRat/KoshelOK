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
        let config = UIImage.SymbolConfiguration(scale: .medium)
        let image = UIImageView(image: UIImage(systemName: "creditcard", withConfiguration: config))
        
        image.tintColor = .white
        
        view.addSubview(image)
        view.layer.cornerRadius = CGFloat(IconSize / 2)
        view.backgroundColor = .activeButtonBackground
        
        image.snp.makeConstraints {make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        return view
    }()
    
    lazy var title: UILabel = {
        let view = UILabel()
        view.font = .SFProRegular16
        return view
    }()
    
    lazy var balance: UILabel = {
        let view = UILabel()
        view.font = .SFProRegular16
        return view
    }()
    
    func configure(with wallet: WalletViewModel) {
        title.text = wallet.name
        balance.text = wallet.balance.toString()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .background
        
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
