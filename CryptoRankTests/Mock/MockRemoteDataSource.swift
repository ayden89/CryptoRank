//
//  MockRemoteDataSource.swift
//  CryptoRankTests
//
//  Created by Tamás Csató on 06/08/2024.
//

import Foundation
@testable import CryptoRank

final class MockRemoteDataSource: CurrencyRemoteDataSourceProtocol {
    var assetItemDTOs: [AssetItemDTO] = []
    var errorToThrow: Error? = nil
    
    func fetchTop10Assets() async throws -> CryptoRank.AssetsResponse {
        if let errorToThrow = errorToThrow {
            throw errorToThrow
        }
        else {
            return BaseResponse(data: assetItemDTOs,
                                timestamp: 0.0)
        }
    }
    
    func fetchAssetDetailForId(_ id: String) async throws -> CryptoRank.AssetDetailResponse {
        if let errorToThrow = errorToThrow {
            throw errorToThrow
        } else if let item = assetItemDTOs.first(where: { id == $0.id }) {
            return BaseResponse(data: item,
                                timestamp: 0.0)
        }
        
        throw AppError.badServerResponse(statusCode: 400)
    }
}
