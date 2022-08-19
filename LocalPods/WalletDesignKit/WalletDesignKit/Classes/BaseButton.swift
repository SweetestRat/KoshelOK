//
//  BaseButton.swift
//  WalletDesignKit
//
//  Created by Владислава Гильде on 11.08.2022.
//

import UIKit

public enum BaseButtonState {
    case loading
    case active
    case inactive
}

public class BaseButton: UIButton {
    override public var isEnabled: Bool {
        didSet {
            if isEnabled == true {
                self.backgroundColor = activeBackgroundColor
                self.setTitleColor(activeTextColor, for: .normal)
                self.isUserInteractionEnabled = true
            } else {
                self.backgroundColor = inactiveBackgroundColor
                self.setTitleColor(inactiveTextColor, for: .normal)
                self.isUserInteractionEnabled = false
            }
        }
    }
    
    public var actionState: BaseButtonState {
        didSet {
            print(actionState)
            switch actionState {
            case .loading:
                titleLabel?.layer.opacity = 0
                loadingIndicator.isHidden = false
                loadingIndicator.startAnimating()
                isEnabled = false
            case .active:
                titleLabel?.layer.opacity = 1
                loadingIndicator.isHidden = true
                loadingIndicator.stopAnimating()
                isEnabled = true
            case .inactive:
                titleLabel?.layer.opacity = 1
                loadingIndicator.isHidden = true
                loadingIndicator.stopAnimating()
                isEnabled = false
            }
        }
    }
    
    var text: String?
    
    public lazy var loadingIndicator: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.isHidden = true
        activityIndicatorView.color = .darkTextPrimaryColor
        return activityIndicatorView
    }()
    
    let activeBackgroundColor = UIColor.activeButtonBackground
    let inactiveBackgroundColor = UIColor.inactiveButtonBackground
    let activeTextColor = UIColor.lightTextPrimaryColor
    let inactiveTextColor = UIColor.darkTextPrimaryColor

    public init(title: String? = nil) {
        self.actionState = .active
        super.init(frame: .zero)
        
        if title != nil {
            text = title
        }
        
        self.setup()
        self.addSubviews()
        self.setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.setTitle(text, for: .normal)
        self.titleLabel?.font = .SFProMedium16
        
        if isEnabled == true {
            self.backgroundColor = activeBackgroundColor
            self.setTitleColor(activeTextColor, for: .normal)
        } else {
            self.backgroundColor = inactiveBackgroundColor
            self.setTitleColor(inactiveTextColor, for: .normal)
        }
        
        self.layer.cornerCurve = .continuous
        self.layer.cornerRadius = CGFloat(MediumPadding)
    }
    
    private func addSubviews() {
        addSubview(loadingIndicator)
    }
    
    private func setConstraints() {
        loadingIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
