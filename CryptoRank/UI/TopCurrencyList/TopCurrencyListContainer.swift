//
//  TopCurrencyListContainer.swift
//  CryptoRank
//
//  Created by Tamás Csató on 05/08/2024.
//

import Foundation
import Swinject

extension Container {
    public static let topCurrencyListContainer: Container = {
        let container = Container(parent: appContainer)
        
        let repositoryContainer = Container.repositoryContainer.synchronize()
        
        container.register(TopCurrencyListViewModel.self,
                           factory: { _ in
            return TopCurrencyListViewModel(currencyRepository: repositoryContainer.resolve(CurrencyRepositoryProtocol.self)!)
        })
        
        container.register(TopCurrencyListView.self,
                           factory: ({ resolver in
            return TopCurrencyListView(viewModel: resolver.resolve(TopCurrencyListViewModel.self)!)
        }))
        
        return container
    }()
}
