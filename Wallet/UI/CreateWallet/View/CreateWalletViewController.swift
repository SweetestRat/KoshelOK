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
    }
    
    private func setup() {
        self.view.addSubview(createWalletView)
        
        createWalletView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        createWalletView.addButtonTarget(self, action: #selector(openWalletsList), for: .touchUpInside)
    }
    
    private func setNavigationBar() {
        navigationItem.title = "Создание кошелька"
    }
    
    @objc private func openWalletsList() {
        presenter.createWallet()
    }
    
    private func setObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        buttonAnimation(notification: notification) { duration, keyboardCurve, keyboard in
            UIView.animate(withDuration: duration, delay: 0, options: UIView.AnimationOptions(rawValue: keyboardCurve)) {
                self.createWalletView.nextButton.snp.remakeConstraints { make in
                    make.bottom.equalTo(self.createWalletView.snp.bottom).offset(-keyboard.height - CGFloat(MediumPadding))
                    make.horizontalEdges.equalTo(self.createWalletView).inset(MediumPadding)
                    make.height.equalTo(ActionButtonHeight)
                }
                self.createWalletView.layoutIfNeeded()
            }
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        buttonAnimation(notification: notification) { duration, keyboardCurve, _ in
            UIView.animate(withDuration: duration, delay: 0, options: UIView.AnimationOptions(rawValue: keyboardCurve)) {
                self.createWalletView.nextButton.snp.remakeConstraints { make in
                    make.bottom.equalTo(self.createWalletView.safeAreaLayoutGuide.snp.bottom).offset(-LargePadding)
                    make.horizontalEdges.equalTo(self.createWalletView).inset(MediumPadding)
                    make.height.equalTo(ActionButtonHeight)
                }
                self.createWalletView.layoutIfNeeded()
            }
        }
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
