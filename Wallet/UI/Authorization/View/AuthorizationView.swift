//
//  AuthorizationView.swift
//  Wallet
//
//  Created by Alexandr Sokolov on 12.08.2022.
//

import UIKit
import WalletDesignKit
import SnapKit

protocol AuthorizationViewDelegateProtocol: AnyObject {
    func emailDidChange(email: String)
}

class AuthorizationView: UIView {
    weak var delegate: AuthorizationViewDelegateProtocol?
    private var bottomConstraint: Constraint?
    
    private lazy var actionButton: BaseButton = {
        let button = BaseButton(title: "Войти")
        button.actionState = .inactive
        return button
    }()
    
    private lazy var logoIcon: UIView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "wallet")
        icon.tintColor = .darkTextPrimaryColor
        return icon
    }()
    
    private lazy var incorrectMailLabel: UILabel = {
        let view = UILabel()
        view.text = "Неправильная почта"
        view.font = .SFProMedium13
        view.textColor = .designRedColor
        view.isHidden = true
        return view
    }()
    
    private lazy var nameTextField: BaseInputTextField = {
        let textField = BaseInputTextField(placeholder: "username@koshelok.ru")
        textField.returnKeyType = .done
        textField.keyboardType = .emailAddress
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
            incorrectMailLabel,
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
        
        incorrectMailLabel.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(SmallPadding)
            make.leading.equalTo(nameTextField.stroke.snp.leading)
        }
        
    }
        
    private func addTargets() {
        nameTextField.addTarget(self, action: #selector(textFieldDidChangeValue), for: .editingChanged)
    }
    
    @objc func textFieldDidChangeValue() {
        delegate?.emailDidChange(email: nameTextField.text ?? "")
    }
    
    func addButtonTarget(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) {
        actionButton.addTarget(target, action: action, for: controlEvents)
    }
    
    func updateBottomInset(valueInset: CGFloat) {
        bottomConstraint?.update(inset: valueInset)
    }
    
    func updateActionButtonState(isEnabled: Bool) {
        actionButton.isEnabled = isEnabled
    }
    
    func updateEmailValidationState(isValid: Bool) {
        if isValid {
            nameTextField.stroke.backgroundColor = .inactiveButtonBackground
        } else {
            nameTextField.stroke.backgroundColor = .designRedColor
        }
        incorrectMailLabel.isHidden = isValid
    }
    
    func changeLoadingState(state: BaseButtonState) {
        actionButton.actionState = state
    }
    
    public func setTextFieldFocus() {
        nameTextField.becomeFirstResponder()
    }
}

extension AuthorizationView: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
