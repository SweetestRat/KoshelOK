//
//  CreateOperationViewController.swift
//  Wallet
//
//  Created by Danila on 13.08.2022.
//

import Foundation
import UIKit
import WalletDesignKit

class CreateOperationViewController: UIViewController, CreateOperationViewProtocol {
    private let presenter: CreateOperationPresenterProtocol
    
    private lazy var createOperationView: CreateOperationView = {
        let view = CreateOperationView()
        view.delegate = self
        return view
    }()
    
    public func updateCurrency(currency: Currency) {
        createOperationView.updateCurrency(currency: currency)
    }
    
    init(presenter: CreateOperationPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewLoaded()
        
        setup()
        setNavigationBar()
        setObservers()
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        createOperationView.addGestureRecognizer(tap)
    }
    
    private func setup() {
        self.view.addSubview(createOperationView)
        
        createOperationView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setNavigationBar() {
        navigationItem.title = "Создание операции"
    }
    
    private func setObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        UIView.animate(withDuration: 5) {
            if let keyboard = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                self.createOperationView.createButton.snp.remakeConstraints {make in
                    make.bottom.equalTo(self.createOperationView.snp.bottom).offset(-keyboard.height - CGFloat(MediumPadding))
                    make.horizontalEdges.equalTo(self.createOperationView).inset(MediumPadding)
                    make.height.equalTo(ActionButtonHeight)
                }
            }
            self.createOperationView.layoutIfNeeded()
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 5) {
            self.createOperationView.createButton.snp.remakeConstraints { make in
                make.bottom.equalTo(self.createOperationView.safeAreaLayoutGuide.snp.bottom).offset(-LargePadding)
                make.horizontalEdges.equalTo(self.createOperationView).inset(MediumPadding)
                make.height.equalTo(ActionButtonHeight)
            }
            self.createOperationView.layoutIfNeeded()
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension CreateOperationViewController: CreateOperationViewDelegate {
    func createOperationViewDidSelectCurrency() {
        presenter.selectCurrency()
    }
}
