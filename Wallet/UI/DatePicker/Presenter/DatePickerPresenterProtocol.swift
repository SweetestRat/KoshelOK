//
//  DatePickerPresenterProtocol.swift
//  Wallet
//
//  Created by Danila on 16.08.2022.
//

import Foundation

protocol DatePickerDelegateProtocol: AnyObject {
    func dateSaved(date: Date)
}

protocol DatePickerPresenterProtocol {
    var delegate: DatePickerDelegateProtocol? { get set }
    var date: Date { get set }
    func dateDidUpdate(date: Date)
    func saveDidClick()
    func cancelDidClick()
    func controllerLoaded()
}
