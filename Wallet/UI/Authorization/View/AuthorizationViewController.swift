//
//  AuthorizationViewController.swift
//  Wallet
//
//  Created by Alexandr Sokolov on 12.08.2022.
//

import Foundation
import UIKit

class AuthorizationViewController: UIViewController, AuthorizationViewProtocol {
    private let presenter: AuthorizationPresenterProtocol
    
    init(presenter: AuthorizationPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let mainView = AuthorizationView()
        view.addSubview(mainView)
        mainView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        mainView.addButtonTarget(self, action: #selector(actionButtonDidTap), for: .touchUpInside)
    }
    
    @objc private func actionButtonDidTap() {
        presenter.actionButtonDidTap()
    }
}
