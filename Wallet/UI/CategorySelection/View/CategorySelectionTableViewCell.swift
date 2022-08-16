//
//  CategorySelectionTableViewCell.swift
//  Wallet
//
//  Created by Alexandr Sokolov on 14.08.2022.
//

import UIKit
import SnapKit
import WalletDesignKit

class CategorySelectionTableViewCell: UITableViewCell {
    
    lazy var icon: UIView = {
        let view = UIView()
        return view
    }()
    
    private(set) lazy var title: UILabel = {
        let label = UILabel()
        label.font = .SFProRegular16
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
        contentView.addSubview(icon)
        contentView.addSubview(title)
    }
    
    private func setConstraints() {
        
        title.snp.makeConstraints { make in
            make.leading.equalTo(icon.snp.trailing).offset(MediumPadding)
            make.centerY.equalToSuperview()
        }
        
        icon.snp.makeConstraints { make in
            make.size.equalTo(IconSize)
            make.centerY.equalToSuperview()
            make.leading.equalTo(contentView).inset(MediumPadding)
        }
        
    }
    
    func configurate(parametres: Category) {
        
        let config = UIImage.SymbolConfiguration(scale: .large)
        let image = UIImageView(image: UIImage(systemName: parametres.iconSystemImage, withConfiguration: config))
        image.tintColor = .white
        icon.addSubview(image)
        
        icon.layer.cornerRadius = CGFloat(IconSize / 2)
        icon.backgroundColor = UIColor(hex: parametres.color)
        
        title.text = parametres.title
        
        image.snp.makeConstraints {make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
}
