//
//  CategorySelectionAssembly.swift
//  Wallet
//
//  Created by Alexandr Sokolov on 14.08.2022.
//

import Foundation

class CategorySelectionAssembly {
    func assembly() -> CategorySelectionViewController {
        let service = CategorySelectionService()
        let router = CategorySelectionRouter()
        let presenter = CategorySelectionPresenter(service: service, router: router)
        let viewController = CategorySelectionViewController(presenter: presenter)

        presenter.view = viewController
        router.view = viewController

        return viewController
    }
}
