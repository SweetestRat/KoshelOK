//
//  CreateOperationView.swift
//  Wallet
//
//  Created by Danila on 13.08.2022.
//

import UIKit
import SnapKit
import WalletDesignKit

protocol CreateOperationViewDelegate: AnyObject {
    func selectCurrency()
}

class CreateOperationView: UIView {
    weak var delegate: CreateOperationViewDelegate?
    
    private lazy var amountTextField: UITextField = {
        let textField = BaseInputTextField(placeholder: "0", font: .SFProBold32, textAllignment: .center)
        textField.keyboardType = .decimalPad
        textField.returnKeyType = .done
        textField.delegate = self
        return textField
    }()
    
    private lazy var currencySymbol: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .SFProBold32
        return label
    }()
    
    private lazy var scrollView = UIScrollView()
    private lazy var parametersLabelCell = labelCell(text: "Параметры")
    private lazy var categorySelector = BaseTextCellWithSelection(title: "Категория", buttonDescriontion: "...")
    private lazy var currencySelector = BaseTextCellWithSelection(title: "Валюта", buttonDescriontion: "...")
    private lazy var dateSelector = BaseTextCellWithSelection(title: "Дата", buttonDescriontion: "...")
    private lazy var operationTypeSelector: UIView = {
        let view = UIView()
        view.snp.makeConstraints { make in
            make.height.equalTo(TableViewCellHeight)
        }
        return view
    }()
    
    lazy var createButton: BaseButton = {
        let button = BaseButton(title: "Создать", active: false)
        return button
    }()
    
    // MARK: public functions
    
    public func updateCurrency(currency: Currency) {
        currencySymbol.text = currency.symbol
        currencySelector.rightButtonDescription.text = currency.fullName
    }
    
    private func labelCell(text: String) -> UIView {
        let cell = UIView()
        let label = UILabel()
        label.font = .SFProBold24
        label.textColor = .darkTextPrimaryColor
        label.text = text
        cell.addSubview(label)
        cell.snp.makeConstraints { make in
            make.height.equalTo(ActionButtonHeight)
        }
        label.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(MediumPadding)
            make.centerY.equalToSuperview()
        }
        return cell
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
        [
            scrollView,
            createButton
        ].forEach { addSubview($0) }
        
        [
            amountTextField,
            operationTypeSelector,
            dateSelector,
            parametersLabelCell,
            categorySelector,
            currencySelector
        ].forEach { scrollView.addSubview($0) }
    }
    
    private func setConstraints() {
        
        scrollView.snp.makeConstraints { make in
            make.leading.trailing.top.equalTo(safeAreaLayoutGuide)
            make.bottom.equalTo(createButton.snp.top)
        }
        amountTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(TableViewCellHeight)
            make.leading.trailing.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(TableViewCellHeight)
        }
        operationTypeSelector.snp.makeConstraints { make in
            make.top.equalTo(amountTextField.snp.bottom)
            make.leading.trailing.equalTo(safeAreaLayoutGuide)
        }
        parametersLabelCell.snp.makeConstraints { make in
            make.top.equalTo(operationTypeSelector.snp.bottom)
            make.leading.trailing.equalTo(safeAreaLayoutGuide)
        }
        categorySelector.snp.makeConstraints { make in
            make.top.equalTo(parametersLabelCell.snp.bottom).offset(MediumPadding)
            make.leading.trailing.equalTo(safeAreaLayoutGuide)
        }
        currencySelector.snp.makeConstraints { make in
            make.top.equalTo(categorySelector.snp.bottom).offset(MediumPadding)
            make.leading.trailing.equalTo(safeAreaLayoutGuide)
        }
        dateSelector.snp.makeConstraints { make in
            make.top.equalTo(currencySelector.snp.bottom).offset(MediumPadding)
            make.leading.trailing.equalTo(safeAreaLayoutGuide)
            make.bottom.equalToSuperview().offset(-MediumPadding)
        }
        createButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(MediumPadding)
            make.leading.trailing.equalToSuperview().inset(MediumPadding)
            make.height.equalTo(ActionButtonHeight)
        }
    }
    
    private func addTargets() {
        amountTextField.addTarget(self, action: #selector(textFieldDidChangeValue), for: .editingChanged)
        currencySelector.addTarget(self, action: #selector(selectCurrency), for: .touchUpInside)
    }
    
    @objc private func textFieldDidChangeValue() {
        if let text = amountTextField.text, !text.isEmpty {
            createButton.isEnabled = true
            
            if text.count > 8 {
                amountTextField.deleteBackward()
            }
        } else {
            createButton.isEnabled = false
        }
    }
    
    @objc private func selectCurrency() {
        delegate?.selectCurrency()
    }
    
}

extension CreateOperationView: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
