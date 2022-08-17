//
//  StringUtils.swift
//  Wallet
//
//  Created by Danila on 17.08.2022.
//

import Foundation

extension String {
    static func ~= (lhs: String, rhs: String) -> Bool {
        guard let regex = try? NSRegularExpression(pattern: rhs) else { return false }
        let range = NSRange(location: 0, length: lhs.utf16.count)
        return regex.firstMatch(in: lhs, options: [], range: range) != nil
    }
}

let emailRegex = "^(?=.{1,64}@)[A-Za-z0-9+_-]+(\\.[A-Za-z0-9+_-]+)*@[^-][A-Za-z0-9+-]+(\\.[A-Za-z0-9+-]+)*(\\.[A-Za-z]{2,})$"
