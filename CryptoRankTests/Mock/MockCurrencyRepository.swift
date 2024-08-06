//
//  MockCurrencyRepository.swift
//  CryptoRankTests
//
//  Created by Tamás Csató on 06/08/2024.
//

import Foundation
@testable import CryptoRank

final class MockCurrencyRepository: CurrencyRepositoryProtocol {
    var assetItems: [AssetItem] = []
    var errorToThrow: Error? = nil
    
    func fetchTop10AssetsAscending() async throws -> [CryptoRank.AssetItem] {
        if let errorToThrow = errorToThrow {
            throw errorToThrow
        }
        else {
            return assetItems
        }
    }
    
    func fetchAssetDetailForId(_ id: String) async throws -> CryptoRank.AssetItem {
        if let errorToThrow = errorToThrow {
            throw errorToThrow
        } else if let item = assetItems.first {
            return item
        }
        
        throw AppError.unknown
    }
}
