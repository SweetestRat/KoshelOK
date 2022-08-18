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
    
    static func from(connection: Reachability.Connection) -> NetworkState {
        switch connection {
        case .none,.unavailable:
            return .unavailable
        case .wifi, .cellular:
            return .available
        }
    }
}

class NetworkReachabilityService {
    weak var delegate: NetworkReachabilityServiceDelegateProtocol?
    let reachability = try? Reachability()
    private var lastSavedState: NetworkState?
    
    func startListening() {
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
        do {
            try reachability?.startNotifier()
        } catch {
            print("could not start reachability notifier")
        }
    }
    
    @objc func reachabilityChanged(note: Notification) {
        guard let connection = (note.object as? Reachability)?.connection else { return }
        let state = NetworkState.from(connection: connection)
        
        if (lastSavedState == nil || state == lastSavedState) {
            lastSavedState = state
            return
        }
        
        switch state {
        case .available:
            delegate?.networkConnectionAppear()
        case .unavailable:
            delegate?.networkConnectionLost()
        }
        lastSavedState = state
    }
}
