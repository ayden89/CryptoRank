//
//  CurrencyDetailContainer.swift
//  CryptoRank
//
//  Created by Tamás Csató on 05/08/2024.
//

import Foundation
import Swinject

extension Container {
    public static let currencyDetailContainer: Container = {
        let container = Container(parent: appContainer)
        
        let repositoryContainer = Container.repositoryContainer.synchronize()
        
        container.register(CurrencyDetailViewModel.self,
                           factory: { _, params in
            return CurrencyDetailViewModel(currencyRepository: repositoryContainer.resolve(CurrencyRepositoryProtocol.self)!,
                                           params: params)
        })
        
        container.register(CurrencyDetailView.self,
                           factory: ({ (resolver: Resolver, params: CurrencyDetailParams) -> CurrencyDetailView in
            return CurrencyDetailView(viewModel: resolver.resolve(CurrencyDetailViewModel.self, argument: params)!)
        }))
        
        return container
    }()
}
