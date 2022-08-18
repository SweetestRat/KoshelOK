//
//  SetupCategoryServiceProtocol.swift
//  Wallet
//
//  Created by Alexandr Sokolov on 18.08.2022.
//

import Foundation

protocol SetupCategoryServiceProtocol {
    func setupCategory(data: SetupCategoryModel, completion: @escaping (Result<Category, Error>) -> Void)
}
