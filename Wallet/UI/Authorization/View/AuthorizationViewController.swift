//
//  AuthorizationViewController.swift
//  Wallet
//
//  Created by Alexandr Sokolov on 12.08.2022.
//

import Foundation
import UIKit

class AuthorizationViewController: UIViewController, AuthorizationViewProtocol {
    var presenter: AuthorizationPresenterProtocol?
    
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
        presenter?.actionButtonDidTap()
    }
}
