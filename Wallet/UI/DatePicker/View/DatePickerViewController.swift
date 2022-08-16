//
//  DatePickerViewController.swift
//  Wallet
//
//  Created by Danila on 16.08.2022.
//

import Foundation
import UIKit

class DatePickerViewController: UIViewController, DatePickerViewProtocol {
    private let presenter: DatePickerPresenterProtocol
    
    private lazy var datePickerView: DatePickerView = {
        let view = DatePickerView()
        view.delegate = self
        return view
    }()
    
    init(presenter: DatePickerPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        presenter.controllerLoaded()
        setupNavigationBar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateDate(date: Date) {
        datePickerView.updateDate(date: date)
    }
    
    private func setupNavigationBar() {
        navigationController?.title = "Выбор времени"
        let leftButton = UIBarButtonItem(title: "Назад", style: .plain, target: self, action: #selector(backButtonClicked))
        let rightButton = UIBarButtonItem(title: "Сохранить", style: .done, target: self, action: #selector(saveButtonClicked))
        self.navigationController?.navigationItem.leftBarButtonItem = leftButton
        self.navigationController?.navigationItem.rightBarButtonItem = rightButton
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
