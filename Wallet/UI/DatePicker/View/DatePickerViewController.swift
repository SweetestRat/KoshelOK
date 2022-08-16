//
//  DatePickerViewController.swift
//  Wallet
//
//  Created by Danila on 16.08.2022.
//

import Foundation
import UIKit
import WalletDesignKit

class DatePickerViewController: UIViewController, DatePickerViewProtocol {
    private let presenter: DatePickerPresenterProtocol
    
    private lazy var datePickerView: DatePickerView = {
        let view = DatePickerView()
        view.delegate = self
        view.backgroundColor = .background
        return view
    }()
    
    init(presenter: DatePickerPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.controllerLoaded()
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        [datePickerView].forEach {
            view.addSubview($0)
        }
    }
    
    private func setConstraints() {
        datePickerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func updateDate(date: Date) {
        datePickerView.updateDate(date: date)
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Выбор времени"
        let leftButton = UIBarButtonItem(title: "Назад", style: .plain, target: self, action: #selector(backButtonClicked))
        let rightButton = UIBarButtonItem(title: "Сохранить", style: .done, target: self, action: #selector(saveButtonClicked))
        navigationItem.leftBarButtonItem = leftButton
        navigationItem.rightBarButtonItem = rightButton
    }
    
    @objc func backButtonClicked() {
        presenter.cancelDidClick()
    }
    
    @objc func saveButtonClicked() {
        presenter.saveDidClick()
    }
}

extension DatePickerViewController: DatePickerViewDelegateProtocol {
    func dateUpdated(date: Date) {
        presenter.dateDidUpdate(date: date)
    }
}
