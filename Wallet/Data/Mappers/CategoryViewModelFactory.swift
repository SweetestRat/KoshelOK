//
//  CategoryViewModelFactory.swift
//  Wallet
//
//  Created by Danila on 18.08.2022.
//

import Foundation

class CategoryViewModelFactory {
    func produce(from: Category) -> CategoryViewModel {
        CategoryViewModel(
            name: from.name,
            iconName: from.iconName,
            iconColor: from.iconColor
        )
    }
}
