//
//  NetworkBanner.swift
//  WalletDesignKit
//
//  Created by Danila on 18.08.2022.
//

import Foundation
import UIKit

public enum NetworkBannerState {
    case available
    case unavailable
}

public class NetworkBanner: UIView {
    private lazy var label: UILabel = {
        let label = UILabel()
        label.font = .SFProMedium16
        label.textColor = .darkTextPrimaryColor
        return label
    }()
    
    private lazy var icon: UIImageView = {
        UIImageView()
    }()
    
    private lazy var iconConnected: UIImage? = {
        UIImage(systemName: "wifi")
    }()
    
    private lazy var iconDisconnected: UIImage? = {
        UIImage(systemName: "wifi.slash")
    }()
    
    public var networkState: NetworkBannerState {
        didSet {
            switch networkState {
            case .available:
                icon.image = iconConnected
                icon.tintColor = .incomeColor
                label.text = "Соединение восстановлено"
            case .unavailable:
                icon.image = iconDisconnected
                icon.tintColor = .designRedColor
                label.text = "Нет соединения с интернетом"
            }
        }
    }
    
    override init(frame: CGRect) {
        networkState = .available
        super.init(frame: frame)
        
        setup()
        addSubviews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = .background
        
        self.layer.cornerCurve = .continuous
        self.layer.cornerRadius = CGFloat(MediumPadding)
    }
    
    private func addSubviews() {
        [
            label,
            icon,
        ].forEach { addSubview($0) }
    }
    
    private func makeConstraints() {
        icon.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(MediumPadding)
            make.centerY.equalToSuperview()
        }
        label.snp.makeConstraints { make in
            make.leading.equalTo(icon.snp.trailing).offset(MediumPadding)
            make.trailing.lessThanOrEqualToSuperview()
            make.centerY.equalToSuperview()
        }
    }
}
