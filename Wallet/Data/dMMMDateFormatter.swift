//
//  dMMMDateFormatter.swift
//  Wallet
//
//  Created by Владислава Гильде on 17.08.2022.
//

import Foundation

class dMMMDateFormatter {
    private lazy var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM YYYY"
        return formatter
    }()
    static let instance: dMMMDateFormatter = dMMMDateFormatter()
    
    private init() {}
    
    func format(timeStamp: Int) -> String {
        let myTimeInterval = TimeInterval(timeStamp)
        let date = Date(timeIntervalSince1970: myTimeInterval)
        return formatter.string(from: date)
    }
}
