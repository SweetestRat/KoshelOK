//
//  StartScreenViewController.swift
//  Wallet
//
//  Created by Alexandr Sokolov on 11.08.2022.
//

import UIKit
import SnapKit

class StartScreenViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        let introImage = UIImageView(image: UIImage(named: "startScreenImage"))
        view.addSubview(introImage)
        introImage.frame.size = CGSize(width: 150, height: 150)
        introImage.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.centerY.equalToSuperview().inset(-50)
        }
    }
}
