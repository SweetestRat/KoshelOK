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
        Category(id: 0, name: "Кафе и рестораны", iconName: "fork.knife", iconColor: "#7765C0"),
        Category(id: 0, name: "Супермаркеты", iconName: "cart", iconColor: "#339FEE"),
        Category(id: 0, name: "Спортзал", iconName: "figure.walk", iconColor: "#994747"),
        Category(id: 0, name: "Общественный транспорт", iconName: "bus", iconColor: "#EE33BA"),
        Category(id: 0, name: "Медицина", iconName: "pills.fill", iconColor: "#16DC71"),
        Category(id: 0, name: "Бензин", iconName: "fuelpump.fill", iconColor: "#EEA333"),
        Category(id: 0, name: "Квартплата", iconName: "house.fill", iconColor: "#91397D"),
        Category(id: 0, name: "Отпуск", iconName: "sun.max.fill", iconColor: "#EEDB33")
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
