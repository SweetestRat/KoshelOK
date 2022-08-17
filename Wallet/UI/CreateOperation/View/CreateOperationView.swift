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
    func createOperationViewDidSelectCurrency()
    func createOperationViewDidSelectDate()
    func dateDidChanged(date: Date)
}

class CreateOperationView: UIView {
    weak var delegate: CreateOperationViewDelegate?
    private var bottomConstraint: Constraint?
    
    private lazy var amountTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "0"
        textField.font = .SFProBold32
        textField.textAlignment = .center
        textField.keyboardType = .decimalPad
        textField.returnKeyType = .done
        textField.delegate = self
        return textField
    }()
    
    private lazy var stroke: UIView = {
       let view = UIView()
       view.backgroundColor = .inactiveButtonBackground
       return view
   }()
    
    private lazy var currencySymbol: UILabel = {
        let label = UILabel()
        label.textColor = .placeholderText
        label.font = .SFProBold32
        return label
    }()
    
    private lazy var scrollView = UIScrollView()
    private lazy var parametersLabelCell = labelCell(text: "Параметры")
    private lazy var categorySelector = BaseTextCellWithSelection(title: "Категория", buttonDescriontion: "...")
    private lazy var currencySelector = BaseTextCellWithSelection(title: "Валюта", buttonDescriontion: "...")
    private lazy var dateSelector = BaseTextCellWithSelection(title: "Дата", buttonDescriontion: "...")
    private lazy var dateSmallSelectorLabel: UILabel = {
        let view = UILabel()
        view.font = .SFProRegular16
        view.textColor = .darkTextPrimaryColor
        view.textAlignment = .left
        view.text = "Дата"
        return view
    }()
    private lazy var datePicker: UIDatePicker = {
        let view = UIDatePicker()
        view.datePickerMode = .dateAndTime
        return view
    }()
    private lazy var operationTypeSelector: UIView = {
        let view = UIView()
        view.snp.makeConstraints { make in
            make.height.equalTo(TableViewCellHeight)
        }
        return view
    }()
    
    private lazy var createButton: BaseButton = {
        let button = BaseButton(title: "Создать", active: false)
        return button
    }()
    
    // MARK: public functions
    
    public func updateCurrency(currency: Currency) {
        currencySymbol.text = currency.shortName
        currencySelector.rightButtonDescription.text = currency.longName
    }
    
    public func updateDate(date: Date) {
        let formatter = DateFormatter()
        formatter.dateFormat = "YY, MMM d, hh:mm"
        dateSelector.rightButtonDescription.text = formatter.string(from: date)
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
        setObservers()
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
            stroke,
            currencySymbol,
            operationTypeSelector,
            parametersLabelCell,
            categorySelector,
            currencySelector
        ].forEach { scrollView.addSubview($0) }
        
        if #available(iOS 14.0, *) {
            [
                dateSmallSelectorLabel,
                datePicker
            ].forEach { scrollView.addSubview($0) }
        } else {
            [
                dateSelector
            ].forEach { scrollView.addSubview($0) }
        }
    }
    
    private func setConstraints() {
        
        scrollView.snp.makeConstraints { make in
            make.leading.trailing.top.equalTo(safeAreaLayoutGuide)
            make.bottom.equalTo(createButton.snp.top)
        }
        amountTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(TableViewCellHeight)
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(TableViewCellHeight)
        }
        stroke.snp.makeConstraints { make in
            make.top.equalTo(amountTextField.snp.bottom)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(MediumPadding)
            make.height.equalTo(StrokeHeight)
        }
        currencySymbol.snp.makeConstraints { make in
            make.leading.equalTo(amountTextField.snp.trailing).offset(SmallPadding)
            make.trailing.equalTo(safeAreaLayoutGuide)
            make.centerY.equalTo(amountTextField)
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
        
        if #available(iOS 14.0, *) {
            dateSmallSelectorLabel.snp.makeConstraints { make in
                make.top.equalTo(currencySelector.snp.bottom).offset(LargePadding)
                make.leading.equalTo(safeAreaLayoutGuide).offset(MediumPadding)
                make.bottom.equalToSuperview().offset(-LargePadding)
            }
            datePicker.snp.makeConstraints { make in
                make.centerY.equalTo(dateSmallSelectorLabel)
                make.leading.greaterThanOrEqualTo(dateSmallSelectorLabel.snp.trailing)
                make.trailing.equalTo(safeAreaLayoutGuide).inset(MediumPadding)
            }
        } else {
            dateSelector.snp.makeConstraints { make in
                make.top.equalTo(currencySelector.snp.bottom).offset(MediumPadding)
                make.leading.trailing.equalTo(safeAreaLayoutGuide)
                make.bottom.equalToSuperview().offset(-LargePadding)
            }
        }
        createButton.snp.makeConstraints { make in
            bottomConstraint = make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(MediumPadding).constraint
            make.leading.trailing.equalToSuperview().inset(MediumPadding)
            make.height.equalTo(ActionButtonHeight)
        }
    }
    
    private func addTargets() {
        amountTextField.addTarget(self, action: #selector(textFieldDidChangeValue), for: .editingChanged)
        currencySelector.addTarget(self, action: #selector(createOperationViewDidSelectCurrency), for: .touchUpInside)
        dateSelector.addTarget(self, action: #selector(createOperationViewDidSelectDate), for: .touchUpInside)
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
    
    @objc private func createOperationViewDidSelectCurrency() {
        delegate?.createOperationViewDidSelectCurrency()
    }
    
    @objc private func createOperationViewDidSelectDate() {
        delegate?.createOperationViewDidSelectDate()
	}

    func updateBottomInset(valueInset: CGFloat) {
        bottomConstraint?.update(inset: valueInset)
    }
    
    private func setObservers() {
        datePicker.addTarget(self, action: #selector(dateChanged), for: UIControl.Event.valueChanged)
    }
    
    @objc func dateChanged() {
        delegate?.dateDidChanged(date: datePicker.date)
    }
    
}

extension CreateOperationView: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
