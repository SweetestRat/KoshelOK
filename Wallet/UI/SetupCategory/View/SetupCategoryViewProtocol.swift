//
//  SetupCategoryViewProtocol.swift
//  Wallet
//
//  Created by Alexandr Sokolov on 18.08.2022.
//

import Foundation
import WalletDesignKit

protocol SetupCategoryViewProtocol: AnyObject {
    func updateActionButtonState(actionState: BaseButtonState)
    func getCategoryName() -> String?
    func getIconName() -> String?
    func getIconColor() -> String?
}
