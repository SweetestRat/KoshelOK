//
//  WalletInfoViewController.swift
//  Wallet
//
//  Created by Владислава Гильде on 13.08.2022.
//

import Foundation
import UIKit

class WalletInfoViewController: UIViewController, WalletInfoViewProtocol {
    private let presenter: WalletInfoPresenterProtocol
    
    init(presenter: WalletInfoPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var walletInfoView: WalletInfoView = {
        let view = WalletInfoView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        view.addSubview(walletInfoView)
        walletInfoView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
