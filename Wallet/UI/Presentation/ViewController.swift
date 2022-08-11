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

    let textfield = BaseInputTextField(placeholder: "напишите текст")

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(textfield)
        
        textfield.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().dividedBy(2)
            make.height.equalTo(50)
        }
    }
}
