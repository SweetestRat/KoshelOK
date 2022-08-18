//
//  NetworkReachabilityService.swift
//  Wallet
//
//  Created by Danila on 18.08.2022.
//

import Foundation
import Reachability

protocol NetworkReachabilityServiceDelegateProtocol: AnyObject {
    func networkConnectionLost()
    func networkConnectionAppear()
}

private enum NetworkState {
    case available
    case unavailable
}

class NetworkReachabilityService {
    weak var delegate: NetworkReachabilityServiceDelegateProtocol?
    let reachability = try? Reachability()
    private var lastState: NetworkState?
    
    func startListening() {
        setupObservers()
        do {
            try reachability?.startNotifier()
        } catch {
            print("could not start reachability notifier")
        }
    }
    
    func setupObservers() {
        reachability?.whenReachable = { [weak self] _ in
            if self?.lastState != nil && self?.lastState != .available {
                self?.delegate?.networkConnectionAppear()
            }
            self?.lastState = .available
        }
        reachability?.whenUnreachable = { [weak self] _ in
            if self?.lastState != .unavailable {
                self?.delegate?.networkConnectionLost()
            }
            self?.lastState = .unavailable
        }
    }
}
