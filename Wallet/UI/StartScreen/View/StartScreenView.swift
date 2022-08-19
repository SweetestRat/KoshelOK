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
        let button = BaseButton(title: "Продолжить")
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
        label.font = .SFProSemiBold32
        label.textColor = .darkTextPrimaryColor
        return label
    }()
    
    private lazy var infoText: UILabel = {
        let label = UILabel()
        label.text = "Тут вы можете контролировать свои доходы и расходы"
        label.numberOfLines = 2
        label.font = .SFProRegular16
        label.textColor = .darkTextPrimaryColor
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
            make.height.equalTo(startScreenView.snp.width)
            make.top.equalTo(safeAreaLayoutGuide.snp.top).inset(MediumPadding)
        }
        
        welcomeText.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(MediumPadding)
            make.top.equalTo(startScreenView.snp.bottom).offset(SmallPadding)
        }
        
        infoText.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(MediumPadding)
            make.top.equalTo(welcomeText.snp.bottom).offset(SmallPadding)
        }
    }
    
    func addButtonTarget(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) {
        actionButton.addTarget(target, action: action, for: controlEvents)
    }
}
