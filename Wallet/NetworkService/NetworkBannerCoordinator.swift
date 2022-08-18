//
//  NetworkBannerCoordinator.swift
//  Wallet
//
//  Created by Danila on 18.08.2022.
//

import Foundation
import UIKit
import WalletDesignKit


class NetworkBannerCoordinator {
    private let networkReachabilityService: NetworkReachabilityService
    private lazy var networkBanner: NetworkBanner = {
        NetworkBanner()
    }()
    weak var window: UIWindow? {
        didSet {
            guard let window = window else { return }
            window.addSubview(networkBanner)
            networkBanner.snp.makeConstraints { make in
                make.leading.trailing.equalToSuperview().inset(MediumPadding)
                make.height.equalTo(ActionButtonHeight)
                make.top.equalTo(window.snp.top).offset(-ActionButtonHeight)
            }
        }
    }
    
    func startListening() {
        networkReachabilityService.startListening()
    }
    
    init(networkReachabilityService: NetworkReachabilityService) {
        self.networkReachabilityService = networkReachabilityService
    }
}

extension NetworkBannerCoordinator: NetworkReachabilityServiceDelegateProtocol {
    func networkConnectionLost() {
        networkBanner.networkState = .unavailable
        animateBanner()
    }
    
    func networkConnectionAppear() {
        networkBanner.networkState = .available
        animateBanner()
    }
    
    private func animateBanner() {
        guard let window = window else { return }
        let topSafeAreaInset = window.safeAreaLayoutGuide.layoutFrame.origin.y
        let centerX = window.safeAreaLayoutGuide.layoutFrame.width / 2
        
        UIView.animateKeyframes(withDuration: 1.5, delay: 0.0, options: [.calculationModeLinear, .autoreverse]) {
            UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.3) {
                self.networkBanner.center = CGPoint(x: centerX, y: topSafeAreaInset + CGFloat((ActionButtonHeight) / 2))
            }
            UIView.addKeyframe(withRelativeStartTime: 1, relativeDuration: 0) {
                self.networkBanner.center = CGPoint(x: centerX, y: -CGFloat((ActionButtonHeight) / 2))
            }
        }
    }
}
