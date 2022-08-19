//
//  AlertExtention.swift
//  Wallet
//
//  Created by Alexandr Sokolov on 17.08.2022.
//

import Foundation
import UIKit

extension UIViewController {
    func exitWaletAlert(title: String, leftButtonTitle: String, rightButtonTitle: String, handler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: leftButtonTitle, style: .destructive, handler: handler))
        alert.addAction(UIAlertAction(title: rightButtonTitle, style: .default))
        
        present(alert, animated: true)
    }
}
