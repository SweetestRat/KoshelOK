//
//  CategorySelectionModelProtocol.swift
//  Wallet
//
//  Created by Alexandr Sokolov on 15.08.2022.
//

import Foundation

protocol CategorySelectionServiceProtocol {
    func getData(complition: @escaping (Result<[Category], Error>) -> Void)
}
