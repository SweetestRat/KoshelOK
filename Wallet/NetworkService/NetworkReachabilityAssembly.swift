//
//  NetworkReachabilityAssembly.swift
//  Wallet
//
//  Created by Danila on 18.08.2022.
//

import Foundation
import UIKit

class NetworkReachabilityAssembly {
    func assembly() -> NetworkBannerCoordinator {
        let networkReachabilityService = NetworkReachabilityService()
        let coordinator = NetworkBannerCoordinator(networkReachabilityService: networkReachabilityService)
        
        networkReachabilityService.delegate = coordinator
        return coordinator
    }
}
