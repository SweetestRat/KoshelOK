//
//  CategorySelectionModelProtocol.swift
//  Wallet
//
//  Created by Alexandr Sokolov on 15.08.2022.
//

import Foundation

protocol CategoriesServiceProtocol {
    func loadCategories(completion: @escaping (Result<[Category], Error>) -> Void)
}
