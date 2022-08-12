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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let v = WalletsScreenView()
        
        view.addSubview(v)
        v.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
