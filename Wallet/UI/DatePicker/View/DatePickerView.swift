//
//  DatePickerView.swift
//  Wallet
//
//  Created by Danila on 16.08.2022.
//

import Foundation
import UIKit
import WalletDesignKit

protocol DatePickerViewDelegateProtocol: AnyObject {
    func dateUpdated(date: Date)
}

class DatePickerView: UIView, DatePickerViewProtocol {
    weak var delegate: DatePickerViewDelegateProtocol?
    
    private lazy var datePicker: UIDatePicker = {
        let view = UIDatePicker()
        view.datePickerMode = .dateAndTime
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setConstraints()
        setObservers()
    }

    func updateDate(date: Date) {
        datePicker.setDate(date, animated: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        [datePicker].forEach {
            addSubview($0)
        }
    }
    
    func setConstraints() {
        datePicker.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(safeAreaLayoutGuide)
        }
    }
    
    func setObservers() {
        datePicker.addTarget(self, action: #selector(dateChanged), for: UIControl.Event.valueChanged)
    }
    
    @objc func dateChanged() {
        delegate?.dateUpdated(date: datePicker.date)
    }
}
