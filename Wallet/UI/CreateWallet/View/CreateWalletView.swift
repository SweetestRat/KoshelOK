//
//  CreateWalletView.swift
//  Wallet
//
//  Created by Владислава Гильде on 11.08.2022.
//

import UIKit
import WalletDesignKit

class CreateWalletView: UIView {
    private lazy var nameTextField: UITextField = {
        let textField = BaseInputTextField(placeholder: "Название")
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
