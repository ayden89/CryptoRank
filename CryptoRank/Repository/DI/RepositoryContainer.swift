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
        
        let dataSourceContainer = Container.dataSourceContainer.synchronize()
        
        container.register(CurrencyRepositoryProtocol.self,
                           factory: { resolver in CurrencyRepository(remoteDataSource: dataSourceContainer.resolve(CurrencyRemoteDataSourceProtocol.self)!) })
        .inObjectScope(.container)
        
        return container
    }()
}
