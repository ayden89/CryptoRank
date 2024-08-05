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
    
    func fetchTop10AssetsAscending() async throws -> [AssetItem] {
        try await self.remoteDataSource
            .fetchTop10Assets()
            .data
            .compactMap({ AssetItem(from: $0) })
            .sorted(by: { $0.rank < $1.rank })
    }
    
    func fetchAssetDetailForId(_ id: String) async throws -> AssetItem {
        let asset = try await self.remoteDataSource.fetchAssetDetailForId(id).data
        if let assetItem = AssetItem(from: asset) {
            return assetItem
        } else {
            throw AppError.decodingError
        }
    }
}
