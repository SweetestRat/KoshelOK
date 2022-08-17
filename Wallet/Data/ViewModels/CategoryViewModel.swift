//
//  CategoryViewModel.swift
//  Wallet
//
//  Created by Владислава Гильде on 16.08.2022.
//

import Foundation

struct CategoryViewModel {
    let name: String
    let iconName: String
    let iconColor: String
    
    init(name: String, iconName: String, iconColor: String) {
        self.name = name
        self.iconName = iconName
        self.iconColor = iconColor
    }
}
