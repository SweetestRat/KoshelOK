//
//  SetupCategoryViewProtocol.swift
//  Wallet
//
//  Created by Alexandr Sokolov on 18.08.2022.
//

import Foundation

protocol SetupCategoryViewProtocol: AnyObject {
    func updateActionButtonState(isActive: Bool)
    func getCategoryName() -> String?
    func getIconName() -> String?
    func getIconColor() -> String?
}
