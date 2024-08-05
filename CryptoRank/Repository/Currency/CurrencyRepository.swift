//
//  CurrencyRepository.swift
//  CryptoRank
//
//  Created by Tamás Csató on 05/08/2024.
//

import Foundation

class CurrencyRepository: CurrencyRepositoryProtocol {
    private let remoteDataSource: CurrencyRemoteDataSourceProtocol
    
    init(remoteDataSource: CurrencyRemoteDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
    }
}
