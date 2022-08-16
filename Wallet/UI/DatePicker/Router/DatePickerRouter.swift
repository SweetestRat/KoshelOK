//
//  DatePickerRouter.swift
//  Wallet
//
//  Created by Danila on 16.08.2022.
//

import Foundation
import UIKit

class DatePickerRouter: DatePickerRouterProtocol {
    weak var view: UIViewController?
    
    func back() {
        view?.navigationController?.dismiss(animated: true)
    }
}
