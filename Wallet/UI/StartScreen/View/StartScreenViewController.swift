//
//  StartScreenViewController.swift
//  Wallet
//
//  Created by Alexandr Sokolov on 12.08.2022.
//

import UIKit
import SnapKit
import WalletDesignKit

class StartScreenViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let startView = StartScreenView()
        view.addSubview(startView)
        startView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
