//
//  CategorySelectionPresenter.swift
//  Wallet
//
//  Created by Alexandr Sokolov on 14.08.2022.
//

import Foundation

class CategorySelectionPresenter: CategorySelectionPresenterProtocol {
    
    private var service: CategoriesServiceProtocol
    private var router: CategorySelectionRouterProtocol
    weak var view: CategorySelectionViewProtocol?
    
    private var selectedIndexPathRow: Int = 0
    
//  TEST
    private var listOfCategories: [Category] = [
        Category(IconSystemImage: "fork.knife", title: "Кафе и рестораны", color: "#7765C0"),
        Category(IconSystemImage: "cart", title: "Супермаркеты", color: "#339FEE"),
        Category(IconSystemImage: "figure.walk", title: "Спортзал", color: "#994747"),
        Category(IconSystemImage: "bus", title: "Общественный транспорт", color: "#EE33BA"),
        Category(IconSystemImage: "pills.fill", title: "Медицина", color: "#16DC71"),
        Category(IconSystemImage: "fuelpump.fill", title: "Бензин", color: "#EEA333"),
        Category(IconSystemImage: "house.fill", title: "Квартплата", color: "#91397D"),
        Category(IconSystemImage: "sun.max.fill", title: "Отпуск", color: "#EEDB33")
    ]
    
    init(service: CategoriesServiceProtocol, router: CategorySelectionRouterProtocol) {
        self.service = service
        self.router = router
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
