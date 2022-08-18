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
    
    private lazy var iconConnected: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "wifi"))
        image.tintColor = .incomeColor
        return image
    }()
    
    private lazy var iconDisconnected: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "wifi.slash"))
        image.tintColor = .designRedColor
        return image
    }()
    
    public var networkState: NetworkBannerState {
        didSet {
            print("Text did set", networkState)
            switch networkState {
            case .available:
                iconConnected.isHidden = false
                iconDisconnected.isHidden = true
                label.text = "Соединение восстановлено"
            case .unavailable:
                iconConnected.isHidden = true
                iconDisconnected.isHidden = false
                label.text = "Нет соединения с интернетом"
            }
            print("iconConnected.isHidden", iconConnected.isHidden)
            print("iconDisconnected.isHidden", iconDisconnected.isHidden)
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
            iconConnected,
            iconDisconnected,
        ].forEach { addSubview($0) }
    }
    
    private func makeConstraints() {
        iconConnected.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(MediumPadding)
            make.centerY.equalToSuperview()
        }
        iconDisconnected.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(MediumPadding)
            make.centerY.equalToSuperview()
        }
        label.snp.makeConstraints { make in
            make.leading.equalTo(iconConnected.snp.trailing).offset(MediumPadding)
            make.trailing.lessThanOrEqualToSuperview()
            make.centerY.equalToSuperview()
        }
    }
}
