//
//  AuthorizationViewController.swift
//  Wallet
//
//  Created by Alexandr Sokolov on 12.08.2022.
//

import Foundation
import UIKit
import WalletDesignKit

class AuthorizationViewController: UIViewController, AuthorizationViewProtocol {
    private let presenter: AuthorizationPresenterProtocol
    
    private lazy var mainView: AuthorizationView = {
        let view = AuthorizationView()
        return view
    }()
    
    init(presenter: AuthorizationPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mainView)
        mainView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        mainView.addButtonTarget(self, action: #selector(actionButtonDidTap), for: .touchUpInside)
        addGestureRecognizer()
        setObservers()
    }
    
    @objc private func actionButtonDidTap() {
        guard let email = mainView.getEmail() else { return }
        mainView.changeLoadingState(state: .start)
        presenter.actionButtonDidTap(email: email)
    }
    
    private func addGestureRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
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
        mainView.updateBottomInset(valueInset: inset)
        
        UIView.animate(using: keyboardAnimationParameters) {
            self.mainView.layoutIfNeeded()
        }
    }
    
    func stopLoading() {
        mainView.changeLoadingState(state: .stop)
    }
    
    func userCreationFailed(error: String) {
        // TODO: show error allert
    }
}
