//
//  AlertExtention.swift
//  Wallet
//
//  Created by Alexandr Sokolov on 17.08.2022.
//

import Foundation
import UIKit

extension UIViewController {
    func exitWaletAlert(handler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: "Уверены, что хотите выйти из аккаунта?", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Да", style: .destructive, handler: handler))
        alert.addAction(UIAlertAction(title: "Нет", style: .default))
        
        present(alert, animated: true)
    }
}
