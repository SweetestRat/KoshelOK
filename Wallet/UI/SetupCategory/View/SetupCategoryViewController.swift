//
//  SetupCategoryViewController.swift
//  Wallet
//
//  Created by Alexandr Sokolov on 14.08.2022.
//

import Foundation
import UIKit
import WalletDesignKit

class SetupCategoryViewController: UIViewController, SetupCategoryViewProtocol {
    
    private let presenter: SetupCategoryPresenterProtocol
    
    private lazy var setupCategoryView: SetupCategoryView = {
        let view = SetupCategoryView()
        view.delegate = self
        return view
    }()
    
    init(presenter: SetupCategoryPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func loadView() {
        view = setupCategoryView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setObservers()
        setup()
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.tintColor = .black
    }
    
    private func setup() {
        setupCategoryView.addButtonTarget(self, action: #selector(ActionButtonDidTap), for: .touchUpInside)
    }
    
    @objc private func ActionButtonDidTap() {
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
        setupCategoryView.updateBottomInset(valueInset: inset)
        
        UIView.animate(using: keyboardAnimationParameters) {
            self.setupCategoryView.layoutIfNeeded()
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func updateActionButtonState(actionState: BaseButtonState) {
        setupCategoryView.updateActionButtonState(actionState: actionState)
    }
    
    func getCategoryName() -> String? {
        setupCategoryView.getCategoryName()
    }
    
    func getIconName() -> String? {
        setupCategoryView.getIconName()
    }
    
    func getIconColor() -> String? {
        setupCategoryView.getIconColor()
    }
}

extension SetupCategoryViewController: SetupCategoryViewDelegate {
    
    func reloadData() {
        self.setupCategoryView.categoriesCollectionView.reloadData()
    }
    
    
    func textFieldDidChangeValue(text: String?) {
        presenter.textFieldDidChanchedValue(text: text)
    }
    
    func cellSelectedForColor(indexPathRow: Int) {
        presenter.setSelectedRowColor(row: indexPathRow)
    }
    
    func cellSelectedForCategory(indexPathRow: Int) {
        presenter.setSelectedRowCategory(row: indexPathRow)
    }
    
    func getSelectedRowForColor() -> Int {
        return presenter.getSelectedRowForColor()
    }
    
    func getSelectedRowForCategory() -> Int {
        return presenter.getSelectedRowForCategory()
    }
}
