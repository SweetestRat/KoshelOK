//
//  CategorySelectionPresenterProtocol.swift
//  Wallet
//
//  Created by Alexandr Sokolov on 14.08.2022.
//

import Foundation

protocol CategorySelectionPresenterProtocol {
    func getSelectedRow() -> Int?
    func setSelectedRow(row: Int)
    func controllerLoaded()
    func didTapBarButton()
}
