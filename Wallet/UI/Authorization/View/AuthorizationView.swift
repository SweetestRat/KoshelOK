//
//  AuthorizationView.swift
//  Wallet
//
//  Created by Alexandr Sokolov on 12.08.2022.
//

import UIKit
import WalletDesignKit
import SnapKit

class AuthorizationView: UIView {
    private var bottomConstraint: Constraint?
    
    private lazy var actionButton: BaseButton = {
        let button = BaseButton(title: "Войти", active: false)
        return button
    }()
    
    private lazy var logoIcon: UIView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "wallet")
        icon.tintColor = .darkTextPrimaryColor
        return icon
    }()
    
    private lazy var nameTextField: UITextField = {
        let textField = BaseInputTextField(placeholder: "username@koshelok.ru")
        textField.returnKeyType = .done
        textField.delegate = self
        return textField
    }()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .background
        
        addSubviews()
        setConstraints()
        addTargets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        [
            logoIcon,
            nameTextField,
            actionButton
        ].forEach { self.addSubview($0) }
    }
    
    private func setConstraints() {
        
        actionButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(MediumPadding)
            make.height.equalTo(ActionButtonHeight)
            bottomConstraint = make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(MediumPadding).constraint
        }
        
        logoIcon.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(LargePadding * 2)
            make.height.equalTo(LogoItemHeight)
            make.width.equalTo(LogoItemWidth)
        }
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(logoIcon.snp.bottom).offset(LargePadding)
            make.leading.trailing.equalToSuperview().inset(MediumPadding)
            make.height.equalTo(TableViewCellHeight)
        }
        
    }
        
    private func addTargets() {
        nameTextField.addTarget(self, action: #selector(textFieldDidChangeValue), for: .editingChanged)
    }
    
    @objc func textFieldDidChangeValue() {
        if let text = nameTextField.text, !text.isEmpty {
            actionButton.isEnabled = true
        } else {
            actionButton.isEnabled = false
        }
    }
    
    func addButtonTarget(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) {
        actionButton.addTarget(target, action: action, for: controlEvents)
    }
    
    func updateBottomInset(valueInset: CGFloat) {
        bottomConstraint?.update(inset: valueInset)
    }
}

extension AuthorizationView: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
