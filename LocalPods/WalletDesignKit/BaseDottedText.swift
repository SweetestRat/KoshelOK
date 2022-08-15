//
//  BaseDottedText.swift
//  WalletDesignKit
//
//  Created by Владислава Гильде on 13.08.2022.
//

import Foundation

public func BaseDottedText(color: UIColor?, text: String, textFont: UIFont) -> UIView {
    let view = UIView()
    let dot = UIView()
    let textView = UILabel()
    
    dot.backgroundColor = color
    dot.layer.cornerCurve = .continuous
    dot.layer.cornerRadius = CGFloat(SmallPadding) / 4
    
    textView.textColor = .lightTextPrimaryColor
    textView.text = text
    textView.font = textFont
    textView.alpha = 0.8
    
    view.addSubview(dot)
    view.addSubview(textView)
    
    dot.snp.makeConstraints { make in
        make.leading.centerY.equalToSuperview()
        make.size.equalTo(SmallPadding)
    }
    
    textView.snp.makeConstraints { make in
        make.leading.equalTo(dot.snp.trailing).offset(SmallPadding)
    }
    
    view.snp.makeConstraints { make in
        make.trailing.equalTo(textView.snp.trailing)
        make.top.bottom.equalTo(textView)
    }
    
    return view
}
