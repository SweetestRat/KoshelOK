//
//  SetupColorCell.swift
//  Wallet
//
//  Created by Alexandr Sokolov on 18.08.2022.
//

import Foundation
import UIKit
import WalletDesignKit

class SetupColorCell: UICollectionViewCell {
    
    var iconColor: String?
    
    lazy var icon: UIView = {
        let view = UIView()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .background
        addSubviews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        icon.frame = bounds
    }
    
    override var isSelected: Bool {
        didSet {
            if (isSelected) {
                icon.subviews.last?.isHidden = false
            } else {
                icon.subviews.last?.isHidden = true
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
        
        self.iconColor = iconColor
        let image = UIImageView(image: UIImage(named: "check"))
        image.tintColor = .lightTextPrimaryColor
        icon.addSubview(image)
        icon.subviews.last?.isHidden = true
        icon.layer.cornerRadius = CGFloat(bounds.height / 2)
        icon.backgroundColor = UIColor(hex: iconColor)
        
        image.snp.makeConstraints {make in
            make.center.equalToSuperview()
        }
    }
}
