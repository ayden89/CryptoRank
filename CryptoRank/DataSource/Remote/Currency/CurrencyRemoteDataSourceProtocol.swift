//
//  CurrencyRemoteDataSourceProtocol.swift
//  CryptoRank
//
//  Created by Tamás Csató on 05/08/2024.
//

import Foundation

protocol CurrencyRemoteDataSourceProtocol {
    func fetchTop10Assets() async throws -> AssetsResponse
    func fetchAssetDetailForId(_ id: String) async throws -> AssetDetailResponse
}
