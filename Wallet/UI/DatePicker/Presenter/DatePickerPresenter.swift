//
//  DatePickerPresenter.swift
//  Wallet
//
//  Created by Danila on 16.08.2022.
//

import Foundation

class DatePickerPresenter: DatePickerPresenterProtocol {
    private let router: DatePickerRouterProtocol
    weak var delegate: DatePickerDelegateProtocol?
    weak var view: DatePickerViewProtocol?
    
    internal var date: Date
    
    init(date: Date, router: DatePickerRouterProtocol) {
        self.date = date
        self.router = router
    }
    
    func controllerLoaded() {
        view?.updateDate(date: date)
    }
    
    func dateDidUpdate(date: Date) {
        self.date = date
    }
    
    func saveDidClick() {
        delegate?.dateSaved(date: date)
        router.back()
    }
    
    func cancelDidClick() {
        router.back()
    }
}
