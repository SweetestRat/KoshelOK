//
//  ViewController.swift
//  Wallet
//
//  Created by a.peresypkin on 05.08.2022.
//

import UIKit
import SnapKit
import WalletDesignKit

class ViewController: UIViewController {

    let test = CreateWalletView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        
        view.addSubview(test)
        
        test.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
