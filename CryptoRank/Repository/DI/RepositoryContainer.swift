//
//  RepositoryContainer.swift
//  CryptoRank
//
//  Created by Tamás Csató on 05/08/2024.
//

import Foundation
import Swinject

extension Container {
    public static let repositoryContainer: Container = {
        let container = Container()
        
        container.register(CurrencyRepositoryProtocol.self,
                           factory: { resolver in CurrencyRepository(remoteDataSource: Container.dataSourceContainer.resolve(CurrencyRemoteDataSourceProtocol.self)!) })
        
        return container
    }()
}
