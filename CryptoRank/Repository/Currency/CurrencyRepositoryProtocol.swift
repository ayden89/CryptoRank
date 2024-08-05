//
//  CurrencyRepositoryProtocol.swift
//  CryptoRank
//
//  Created by Tamás Csató on 05/08/2024.
//

import Foundation

protocol CurrencyRepositoryProtocol {
    func fetchTop10AssetsAscending() async throws -> [AssetItem]
    func fetchAssetDetailForId(_ id: String) async throws -> AssetItem
}
