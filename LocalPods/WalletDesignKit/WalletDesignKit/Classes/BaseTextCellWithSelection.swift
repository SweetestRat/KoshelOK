//
//  BaseTextFieldWithSelection.swift
//  WalletDesignKit
//
//  Created by Владислава Гильде on 11.08.2022.
//

import UIKit
import SnapKit

public class BaseTextCellWithSelection: UIView {
    private lazy var title: UILabel = {
        let label = UILabel()
        label.font = .designSFProRegular17
        label.textColor = .darkTextPrimaryColor
        label.textAlignment = .left
        return label
    }()
    
    private lazy var rightButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .none
        return button
    }()
    
    private lazy var rightButtonView: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = false
        return view
    }()
    
    private lazy var rightButtonDescription: UILabel = {
        let label = UILabel()
        label.font = .designSFProRegular17
        label.textColor = .inputPlaceholderColor
        return label
    }()
    
    private lazy var rightButtonArrow: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .smallArrow
        imageView.tintColor = .inputPlaceholderColor
        return imageView
    }()
    
    public convenience init(title: String, buttonDescriontion: String) {
        self.init(frame: .zero)
        
        self.title.text = title
        self.rightButtonDescription.text = buttonDescriontion
        self.isUserInteractionEnabled = true
        
        addSubviews()
        setConstraints()
    }
    
    private func addSubviews() {
        [title, rightButton].forEach { addSubview($0)}
        rightButton.addSubview(rightButtonView)
        [rightButtonDescription, rightButtonArrow].forEach { rightButtonView.addSubview($0) }
    }
    
    private func setConstraints() {
        title.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(MediumPadding)
        }
        
        rightButton.snp.makeConstraints { make in
            make.height.equalToSuperview()
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview()
            make.leading.equalTo(rightButtonDescription.snp.leading)
        }
        
        rightButtonView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        rightButtonArrow.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(MediumPadding)
        }
        
        rightButtonDescription.snp.makeConstraints { make in
            make.trailing.equalTo(rightButtonArrow.snp.leading).offset(-SmallPadding)
            make.centerY.equalToSuperview()
        }
    }
    
    public func addTarget(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) {
        rightButton.addTarget(target, action: action, for: controlEvents)
    }
}
