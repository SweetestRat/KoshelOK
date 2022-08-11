//
//  BaseButton.swift
//  WalletDesignKit
//
//  Created by Владислава Гильде on 11.08.2022.
//

import UIKit

public class BaseButton: UIButton {
//    var isChecked: Bool = false {
//        didSet {
//            if isChecked == true {
//                self.setImage(.checkBoxIcon, for: .normal)
//            } else {
//                self.setImage(nil, for: .normal)
//            }
//        }
//    }
    
//    var isActive: Bool {
//        didSet {
//            if isActive == true {
//
//            }
//        }
//    }
    
    let activeColor = UIColor.activeButtonBackground
    let inactiveColor = UIColor.inactiveButtonBackground
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = activeColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
