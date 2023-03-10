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
    private let impactFeedbackgenerator = UINotificationFeedbackGenerator()
    
    private lazy var mainView: AuthorizationView = {
        let view = AuthorizationView()
        view.delegate = self
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mainView.setTextFieldFocus()
    }
    
    @objc private func actionButtonDidTap() {
        presenter.actionButtonDidTap()
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
    
    func updateEmailValidationState(isValid: Bool) {
        mainView.updateEmailValidationState(isValid: isValid)
    }
    
    func updateActionButtonState(baseButtonState: BaseButtonState) {
        mainView.updateActionButtonState(baseButtonState: baseButtonState)
    }
    
    func userCreationFailed(error: String) {
        // TODO: show error allert
    }
}

extension AuthorizationViewController: AuthorizationViewDelegateProtocol {
    func emailDidChange(email: String) {
        presenter.emailDidChange(email: email)
    }
    
    func incorrectEmailPassed() {
        impactFeedbackgenerator.notificationOccurred(.error)
    }
}
