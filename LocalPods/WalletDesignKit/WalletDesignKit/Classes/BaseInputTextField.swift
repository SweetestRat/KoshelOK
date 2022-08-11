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
    
    public convenience init(placeholder: String? = nil, title: String? = nil) {
        self.init()
        
        if placeholder == placeholder {
            self.placeholderText = placeholder
        }
        
        if title == title {
            self.title = title
        }
        
        setup()
    }
    
    private func setup() {
        text = title
        guard let color = UIColor.inputPlaceholderColor else { return }
        attributedPlaceholder = NSAttributedString(
            string: placeholderText ?? "",
            attributes: [NSAttributedString.Key.foregroundColor: color]
        )
        textColor = .darkTextPrimaryColor
        font = .SFProRegular(size: 17)
        backgroundColor = .none
        self.layer.cornerCurve = .continuous
        layer.cornerRadius = 16
        layer.borderWidth = 2
        layer.borderColor = UIColor.inactiveButtonBackground?.cgColor
    }
    
    public override func textRect(forBounds bounds: CGRect) -> CGRect {
        return super.textRect(forBounds: bounds.inset(by: UIEdgeInsets(top: CGFloat(MediumPadding),
                                                                       left: CGFloat(MediumPadding),
                                                                       bottom: CGFloat(MediumPadding),
                                                                       right: CGFloat(MediumPadding))))
    }

    public override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return super.editingRect(forBounds: bounds.inset(by: UIEdgeInsets(top: CGFloat(MediumPadding),
                                                                          left: CGFloat(MediumPadding),
                                                                          bottom: CGFloat(MediumPadding),
                                                                          right: CGFloat(MediumPadding))))
    }
}
