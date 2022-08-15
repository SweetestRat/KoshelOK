//
//  StartScreenViewController.swift
//  Wallet
//
//  Created by Alexandr Sokolov on 12.08.2022.
//

import UIKit
import SnapKit
import WalletDesignKit

class StartScreenViewController: UIViewController, StartScreenViewProtocol {
    private let presenter: StartScreenPresenterProtocol
    
    init(presenter: StartScreenPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let startView = StartScreenView()
        view.addSubview(startView)
        
        startView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        startView.addButtonTarget(self, action: #selector(actionButtonDidTap), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @objc private func actionButtonDidTap() {
        presenter.actionButtonDidTap()
    }
}
