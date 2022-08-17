//
//  CreateWalletViewController.swift
//  Wallet
//
//  Created by Владислава Гильде on 11.08.2022.
//

import UIKit
import WalletDesignKit

class CreateWalletViewController: UIViewController, CreateWalletViewProtocol {
    private let presenter: CreateWalletPresenterProtocol
    
    init(presenter: CreateWalletPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var createWalletView: CreateWalletView = {
        let view = CreateWalletView()
        view.delegate = self
        return view
    }()
    
    public func updateActionButtonState(isActive: Bool) {
        createWalletView.updateActionButtonState(isActive: isActive)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setNavigationBar()
        setObservers()
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        createWalletView.addGestureRecognizer(tap)
        presenter.controllerLoaded()
    }
    
    private func setup() {
        self.view.addSubview(createWalletView)
        
        createWalletView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        createWalletView.addButtonTarget(self, action: #selector(nextButtonDidTap), for: .touchUpInside)
    }
    
    private func setNavigationBar() {
        navigationItem.title = "Создание кошелька"
    }
    
    @objc private func nextButtonDidTap() {
        createWalletView.changeLoadingState(state: .start)
        presenter.createButtonDidTap()
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
        createWalletView.updateBottomInset(valueInset: inset)
        
        UIView.animate(using: keyboardAnimationParameters) {
            self.createWalletView.layoutIfNeeded()
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func updateCurrency(currency: Currency) {
        createWalletView.updateCurrency(currency: currency)
    }
    
    func getWalletName() -> String? {
        return createWalletView.getWalletName()
    }
    
    func walletCreationFailed(error: String) {
        // TODO: show error allert
    }
    
    func stopLoading() {
        createWalletView.changeLoadingState(state: .stop)
    }
}

extension CreateWalletViewController: CreateWalletViewDelegate {
    func cellCurrencyInfoDidTap() {
        presenter.cellCurrencyInfoDidTap()
    }
    
    func textFieldDidChangeValue(text: String?) {
        presenter.textFieldDidChanchedValue(text: text)
    }
}
