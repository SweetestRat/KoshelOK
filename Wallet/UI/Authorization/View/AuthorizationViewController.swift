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
        buttonAnimation(notification: notification) { duration, keyboardCurve, keyboard in
            UIView.animate(withDuration: duration, delay: 0, options: UIView.AnimationOptions(rawValue: keyboardCurve)) {
                self.mainView.actionButton.snp.remakeConstraints { make in
                    make.bottom.equalTo(self.mainView.snp.bottom).offset(-keyboard.height - CGFloat(MediumPadding))
                    make.horizontalEdges.equalTo(self.mainView).inset(MediumPadding)
                    make.height.equalTo(ActionButtonHeight)
                }
                self.mainView.layoutIfNeeded()
            }
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        buttonAnimation(notification: notification) { duration, keyboardCurve, _ in
            UIView.animate(withDuration: duration, delay: 0, options: UIView.AnimationOptions(rawValue: keyboardCurve)) {
                self.mainView.actionButton.snp.remakeConstraints { make in
                    make.bottom.equalTo(self.mainView.safeAreaLayoutGuide.snp.bottom).offset(-LargePadding)
                    make.horizontalEdges.equalTo(self.mainView).inset(MediumPadding)
                    make.height.equalTo(ActionButtonHeight)
                }
                self.mainView.layoutIfNeeded()
            }
        }
    }
}
