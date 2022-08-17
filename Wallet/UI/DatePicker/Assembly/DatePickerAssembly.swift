//
//  DatePickerAssembly.swift
//  Wallet
//
//  Created by Danila on 16.08.2022.
//

import Foundation

class DatePickerAssembly {
    func assembly(delegate: DatePickerDelegateProtocol, date: Date) -> DatePickerViewController {
        let router = DatePickerRouter()
        let presenter = DatePickerPresenter(date: date, router: router)
        let viewController = DatePickerViewController(presenter: presenter)

        router.view = viewController
        presenter.view = viewController
        presenter.delegate = delegate
        
        return viewController
    }
}
