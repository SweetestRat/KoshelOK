//
//  SetupCategoryPresenterProtocol.swift
//  Wallet
//
//  Created by Alexandr Sokolov on 18.08.2022.
//

import Foundation

protocol SetupCategoryPresenterProtocol: AnyObject {
    func createButtonDidTap()
    func openCategorySelection()
    func textFieldDidChanchedValue(text: String?)
    func controllerLoaded()
    func setSelectedRowColor(row: Int)
    func setSelectedRowCategory(row: Int)
    func getSelectedRowForColor() -> Int
    func getSelectedRowForCategory() -> Int
}
