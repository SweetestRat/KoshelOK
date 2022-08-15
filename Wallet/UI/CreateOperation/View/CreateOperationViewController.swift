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
    var presenter: CreateOperationPresenterProtocol?
    
    private lazy var createOperationView: CreateOperationView = {
        let view = CreateOperationView()
        view.delegate = self
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
                self.createOperationView.createButton.snp.updateConstraints {make in
                    make.bottom.equalTo(self.createOperationView.safeAreaLayoutGuide.snp.bottom).offset(CGFloat(LargePadding) - keyboard.height)
                }
            }
            self.createOperationView.layoutIfNeeded()
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 5) {
            self.createOperationView.createButton.snp.updateConstraints { make in
                make.bottom.equalTo(self.createOperationView.safeAreaLayoutGuide.snp.bottom).offset(-LargePadding)
            }
            self.createOperationView.layoutIfNeeded()
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension CreateOperationViewController: CreateOperationViewDelegate {
    func selectCurrency() {
        presenter?.selectCurrency()
    }
}
