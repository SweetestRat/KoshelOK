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
    
    public func updateDate(date: Date) {
        createOperationView.updateDate(date: date)
    }
    
    public func updateOperationType(operationType: OperationType) {
        createOperationView.updateOperationType(operationType: operationType)
    }
    
    public func updateCategory(category: CategoryViewModel) {
        createOperationView.updateCategory(category: category)
    }
    
    public func updateActionButtonState(state: BaseButtonState) {
        createOperationView.updateActionButtonState(state: state)
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        createOperationView.setAmountFieldFocus()
    }
    
    private func setup() {
        self.view.addSubview(createOperationView)
        
        createOperationView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setNavigationBar() {
        navigationItem.title = "???????????????? ????????????????"
    }
    
    private func setObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let keyboardAnimationParameters = KeyboardAnimationParameters(notification: notification) else { return }
        let keyboardHeight = keyboardAnimationParameters.keyboardFrame.height
        let bottomSafeAreaHeight = view.safeAreaInsets.bottom
        let inset = keyboardHeight - bottomSafeAreaHeight + CGFloat(MediumPadding)
        
        updateConstraints(inset: inset, keyboardAnimationParameters: keyboardAnimationParameters)
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        guard let keyboardAnimationParameters = KeyboardAnimationParameters(notification: notification) else { return }
        updateConstraints(inset: CGFloat(MediumPadding), keyboardAnimationParameters: keyboardAnimationParameters)
    }
    
    private func updateConstraints(inset: CGFloat, keyboardAnimationParameters: KeyboardAnimationParameters) {
        createOperationView.updateBottomInset(valueInset: inset)
        
        UIView.animate(using: keyboardAnimationParameters) {
            self.createOperationView.layoutIfNeeded()
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension CreateOperationViewController: CreateOperationViewDelegate {
    func createOperationViewDidSelectIncome() {
        presenter.incomeDidSelected()
    }
    
    func createOperationViewDidSelectExpanse() {
        presenter.expanseDidSelected()
    }
    
    func createOperationViewDidSelectCategory() {
        presenter.selectCategory()
    }
    
    func createOperationViewDidSelectCurrency() {
        presenter.selectCurrency()
    }
    
    func createOperationViewDidSelectDate() {
        presenter.selectDate()
    }
    
    func createOperationViewDidTapCreate() {
        presenter.createDidTap()
    }
    
    func createOperationViewAmountDidChange(amount: String) {
        presenter.amountDidChange(amount: amount)
    }
    
    func dateDidChanged(date: Date) {
        presenter.dateDidChanged(date: date)
    }
    
    func getMaxAmountValue() -> Double {
        presenter.getMaxAmountValue()
    }
}
