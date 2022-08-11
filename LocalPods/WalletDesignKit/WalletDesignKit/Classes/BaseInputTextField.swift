//
//  BaseInputTextField.swift
//  WalletDesignKit
//
//  Created by Владислава Гильде on 11.08.2022.
//

import UIKit
import SnapKit

public class BaseInputTextField: UITextField {
    var placeholderText: String?
    var title: String?
    
    private lazy var stroke: UIView = {
        let view = UIView()
        view.backgroundColor = .strokeColor
        return view
    }()
    
    public convenience init(placeholder: String? = nil, title: String? = nil) {
        self.init()
        
        if placeholder == placeholder {
            self.placeholderText = placeholder
        }
        
        if title == title {
            self.title = title
        }
        
        setup()
        setConstraints()
    }
    
    private func setup() {
        text = title
        attributedPlaceholder = NSAttributedString(
            string: placeholderText ?? "",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.inputPlaceholderColor]
        )
        textColor = .inactiveTextPrimaryColor
        font = .SFProRegular(size: 17)
        backgroundColor = .none
        
        self.addSubview(stroke)
    }
    
    private func setConstraints() {
        stroke.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(2)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
