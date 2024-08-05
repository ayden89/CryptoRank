//
//  DataSourceContainer.swift
//  CryptoRank
//
//  Created by Tamás Csató on 05/08/2024.
//

import Foundation
import Swinject

extension Container {
    public static let dataSourceContainer: Container = {
        let container = Container(parent: appContainer)
        
        container.register(CurrencyRemoteDataSourceProtocol.self, factory: { _ in CurrencyRemoteDataSource() })
        
        return container
    }()
}
