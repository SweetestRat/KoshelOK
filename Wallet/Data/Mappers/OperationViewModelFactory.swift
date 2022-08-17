//
//  OperationViewModelFactory.swift
//  Wallet
//
//  Created by Danila on 18.08.2022.
//

import Foundation

class OperationViewModelFactoryAssembly {
    func assembly() -> OperationViewModelFactory {
        let categoryFactory = CategoryViewModelFactoryAssembly().assembly()
        let balanceFactory = BalanceViewModelFactoryAssembly().assembly()
        return OperationViewModelFactory(categoryFactory: categoryFactory, balanceFactory: balanceFactory)
    }
}

class OperationViewModelFactory {
    private let categoryFactory: CategoryViewModelFactory
    private let balanceFactory: BalanceViewModelFactory
    
    init(categoryFactory: CategoryViewModelFactory, balanceFactory: BalanceViewModelFactory) {
        self.categoryFactory = categoryFactory
        self.balanceFactory = balanceFactory
    }
    
    func produce(from: Operation) -> OperationViewModel {
        let date = dMMMDateFormatter.instance.format(timeStamp: from.date)
        let time = TimeFormatter.instance.format(timeStamp: from.date)
        return OperationViewModel(
            category: categoryFactory.produce(from: from.categoryDto),
            balance: balanceFactory.produce(from: from.balanceDto),
            date: date,
            time: time
        )
    }
}
