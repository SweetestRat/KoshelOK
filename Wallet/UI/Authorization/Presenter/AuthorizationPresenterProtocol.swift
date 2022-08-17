//
//  AuthorizationPresenterProtocol.swift
//  Wallet
//
//  Created by Alexandr Sokolov on 12.08.2022.
//

import Foundation

protocol AuthorizationPresenterProtocol: AnyObject {
    func actionButtonDidTap(email: String)
}
