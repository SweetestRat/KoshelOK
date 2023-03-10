//
//  UserSettings.swift
//  Wallet
//
//  Created by Alexandr Sokolov on 17.08.2022.
//

import Foundation

private enum SettingsKeys: String {
    case userId
    case userName
}

final class UserSettings {
    private let userDefaults: UserDefaults
    
    static let userDefaults = UserSettings(userDefaults: UserDefaults())
    
    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }
    
    var userId: Int? {
        get {
            return userDefaults.object(forKey: SettingsKeys.userId.rawValue) as? Int
        } set {
            let key = SettingsKeys.userId.rawValue
            userDefaults.set(newValue, forKey: key)
        }
    }
    
    var userName: String? {
        get {
            return userDefaults.string(forKey: SettingsKeys.userName.rawValue)
        } set {
            let key = SettingsKeys.userName.rawValue
            if let name = newValue {
                userDefaults.set(name, forKey: key)
            } else {
                userDefaults.removeObject(forKey: key)
            }
        }
    }
    
    func exitFromAccount() {
        userId = nil
        userName = nil
    }
}
