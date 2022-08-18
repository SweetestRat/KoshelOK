//
//  SetupCategoryCell.swift
//  Wallet
//
//  Created by Alexandr Sokolov on 14.08.2022.
//

import Foundation
import UIKit
import WalletDesignKit

class SetupCategoryCell: UICollectionViewCell {
    
    var iconColor: String?
    private var image: UIImageView?
    
    lazy var icon: UIView = {
        let view = UIView()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .background
        icon.layer.cornerRadius = CGFloat(bounds.width / 2)
        addSubviews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        icon.frame = bounds
    }
    
    override var isSelected: Bool {
        didSet {
            if (isSelected) {
                icon.layer.borderColor = UIColor(hex: "#333333")?.cgColor
                icon.layer.borderWidth = 3
            } else {
                icon.layer.borderWidth = 0
            }
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        contentView.addSubview(icon)
    }

    func configurate(iconName: String, iconColor: String) {
        image?.removeFromSuperview()
        
        self.iconColor = iconColor
        let config = UIImage.SymbolConfiguration(scale: .large)
        image = UIImageView(image: UIImage(systemName: iconName, withConfiguration: config))
        image?.tintColor = .lightTextPrimaryColor
        guard let image = image else { return }
        icon.addSubview(image)
        
        UIView.animate(withDuration: 0.2) {
            self.icon.backgroundColor = UIColor(hex: iconColor)
        }
        
        
        image.snp.makeConstraints {make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
}
