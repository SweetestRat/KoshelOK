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
    
    private lazy var welcomeText: UILabel = {
        let label = UILabel()
        label.text = "Добро пожаловать в КошелОК"
        label.numberOfLines = 2
        label.font = .designSFProMedium32
        label.textColor = .black
        
        return label
    }()
    
    private lazy var infoText: UILabel = {
        
        let label = UILabel()
        label.text = "Тут вы можете контролировать свои доходы и расходы"
        label.numberOfLines = 2
        label.font = .designSFProMedium16
        label.textColor = .black
        
        return label
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
            startScreenView,
            actionButton,
            welcomeText,
            infoText
        ].forEach { self.addSubview($0) }
    }
    
    private func setConstraints() {
        
        actionButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(MediumPadding)
            make.height.equalTo(ActionButtonHeight)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(MediumPadding)
        }
        
        startScreenView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(SmallPadding)
            make.height.equalTo(StartScreenImageHeight)
            make.width.equalTo(StartScreenImageWidth)
            make.top.equalToSuperview()
        }
        
        welcomeText.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(MediumPadding)
            make.top.equalTo(startScreenView.snp.bottom).offset(LargePadding * 2)
        }
        
        infoText.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(MediumPadding)
            make.top.equalTo(welcomeText.snp.bottom).offset(SmallPadding)
        }
    }
}
