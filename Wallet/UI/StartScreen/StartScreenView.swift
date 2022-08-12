//
//  StartScreenView.swift
//  Wallet
//
//  Created by Alexandr Sokolov on 12.08.2022.
//

import UIKit
import WalletDesignKit

class StartScreenView: UIView {
    
    private lazy var actionButton: BaseButton = {
        let button = BaseButton(title: "Войти")
        return button
    }()
    
    private lazy var startScreenView: UIView = {
        let view = UIImageView()
        view.image = UIImage(named: "startScreenImage")
        return view
    }()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .background
        
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        [
            startScreenView
        ].forEach { self.addSubview($0) }
    }
    
    private func setConstraints() {
        startScreenView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview()
        }
    }
}
