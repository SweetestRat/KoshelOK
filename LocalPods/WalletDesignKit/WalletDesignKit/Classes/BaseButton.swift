//
//  BaseButton.swift
//  WalletDesignKit
//
//  Created by Владислава Гильде on 11.08.2022.
//

import UIKit

public class BaseButton: UIButton {
    public var isActive: Bool? {
        didSet {
            if isActive == true {
                self.backgroundColor = activeBackgroundColor
                self.setTitleColor(activeTextColor, for: .normal)
            } else {
                self.backgroundColor = inactiveBackgroundColor
                self.setTitleColor(inactiveTextColor, for: .normal)
            }
        }
    }
    
    var text: String?
    
    let activeBackgroundColor = UIColor.activeButtonBackground
    let inactiveBackgroundColor = UIColor.inactiveButtonBackground
    let activeTextColor = UIColor.lightTextPrimaryColor
    let inactiveTextColor = UIColor.darkTextPrimaryColor

    public convenience init(title: String? = nil, active: Bool? = true) {
        self.init(type: .custom)
        
        if active == active {
            isActive = active
        }
        
        if title == title {
            text = title
        }
        
        setup()
    }
    
    private func setup() {
        self.setTitle(text, for: .normal)
        self.titleLabel?.font = .designSFProRegular17
        
        if isActive == true {
            self.backgroundColor = activeBackgroundColor
            self.setTitleColor(activeTextColor, for: .normal)
        } else {
            self.backgroundColor = inactiveBackgroundColor
            self.setTitleColor(inactiveTextColor, for: .normal)
        }
        
        self.layer.cornerCurve = .continuous
        self.layer.cornerRadius = 16
    }
}
