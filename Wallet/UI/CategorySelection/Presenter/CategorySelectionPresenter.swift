//
//  CategorySelectionPresenter.swift
//  Wallet
//
//  Created by Alexandr Sokolov on 14.08.2022.
//

import Foundation

class CategorySelectionPresenter: CategorySelectionPresenterProtocol {
    
    private var service: CategoriesServiceProtocol
    weak var view: CategorySelectionViewProtocol?
    
    private var selectedIndexPathRow: Int = 0
    
//  TEST
    private var listOfCategories: [Category] = [
        Category(iconSystemImage: "fork.knife", title: "Кафе и рестораны", color: "#7765C0"),
        Category(iconSystemImage: "cart", title: "Супермаркеты", color: "#339FEE"),
        Category(iconSystemImage: "figure.walk", title: "Спортзал", color: "#994747"),
        Category(iconSystemImage: "bus", title: "Общественный транспорт", color: "#EE33BA"),
        Category(iconSystemImage: "pills.fill", title: "Медицина", color: "#16DC71"),
        Category(iconSystemImage: "fuelpump.fill", title: "Бензин", color: "#EEA333"),
        Category(iconSystemImage: "house.fill", title: "Квартплата", color: "#91397D"),
        Category(iconSystemImage: "sun.max.fill", title: "Отпуск", color: "#EEDB33")
    ]
    
    init(service: CategoriesServiceProtocol) {
        self.service = service
    }
    
    func getSelectedRow() -> Int? {
        return selectedIndexPathRow
    }
    
    func setSelectedRow(row: Int) {
        selectedIndexPathRow = row
    }
    
    func controllerLoaded() {
    }
    
    func didTapBarButton() {}
    
    func getNumberOfRows() -> Int? {
        listOfCategories.count
    }
    
    func getCategory(index: Int) -> Category {
        listOfCategories[index]
    }
}
