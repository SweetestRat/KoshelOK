//
//  CategorySelectionPresenterProtocol.swift
//  Wallet
//
//  Created by Alexandr Sokolov on 14.08.2022.
//

import Foundation

protocol CategorySelectionDelegateProtocol: AnyObject {
    func categorySaved(category: Category)
}

protocol CategorySelectionPresenterProtocol {
    func getSelectedRow() -> Int?
    func setSelectedRow(row: Int)
    func controllerLoaded()
    func actionButtonDidTap()
    func getNumberOfRows() -> Int?
    func getCategory(index: Int) -> CategoryViewModel
    func categoryDidUpdate(category: CategoryViewModel)
    func cancelDidClick()
    func addNewCategory()
}
