//
//  CreateWalletView.swift
//  Wallet
//
//  Created by Владислава Гильде on 11.08.2022.
//

import UIKit
import SnapKit
import WalletDesignKit

class CreateWalletView: UIView {
    private lazy var nameTextField: UITextField = {
        let textField = BaseInputTextField(placeholder: "Название")
        return textField
    }()
    
    private lazy var currencyView: UIView = {
        let view = BaseTextCellWithSelection(title: "Валюта", buttonDescriontion: "Российский рубль")
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        [nameTextField, currencyView].forEach { addSubview($0) }
    }
    
    private func setConstraints() {
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(70)
        }
        
        currencyView.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(70)
        }
    }
}
