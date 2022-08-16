//
//  CreateWalletView.swift
//  Wallet
//
//  Created by Владислава Гильде on 11.08.2022.
//

import UIKit
import SnapKit
import WalletDesignKit

protocol CreateWalletViewDelegate: AnyObject {
    func cellCurrencyInfoDidTap()
    func textFieldDidChangeValue(text: String?)
}

class CreateWalletView: UIView {
    weak var delegate: CreateWalletViewDelegate?
    
    private lazy var nameTextField: UITextField = {
        let textField = BaseInputTextField(placeholder: "Название")
        textField.returnKeyType = .done
        textField.delegate = self
        return textField
    }()
    
    private lazy var currencyView: BaseTextCellWithSelection = {
        let view = BaseTextCellWithSelection(title: "Валюта", buttonDescriontion: "Российский рубль")
        return view
    }()
    
    public lazy var nextButton: BaseButton = {
        let button = BaseButton(title: "Создать кошелек", active: false)
        return button
    }()
    
    public func updateActionButtonState(isActive: Bool) {
        nextButton.isEnabled = isActive
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .background
        
        addSubviews()
        setConstraints()
        addTargets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        [nameTextField, currencyView, nextButton].forEach { addSubview($0) }
    }
    
    private func setConstraints() {
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(50)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
        
        currencyView.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(70)
        }
        
        nextButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(MediumPadding)
            make.leading.trailing.equalToSuperview().inset(MediumPadding)
            make.height.equalTo(ActionButtonHeight)
        }
    }
    
    private func addTargets() {
        nameTextField.addTarget(self, action: #selector(textFieldDidChangeValue), for: .editingChanged)
        currencyView.addTarget(self, action: #selector(currencyInfoDidTap), for: .touchUpInside)
    }
    
    @objc func textFieldDidChangeValue() {
        delegate?.textFieldDidChangeValue(text: nameTextField.text)
    }
    
    @objc private func currencyInfoDidTap() {
        delegate?.cellCurrencyInfoDidTap()
    }
    
    func addButtonTarget(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) {
        nextButton.addTarget(target, action: action, for: controlEvents)
    }
}

extension CreateWalletView: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
