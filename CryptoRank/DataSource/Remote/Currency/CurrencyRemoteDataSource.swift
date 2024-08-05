//
//  CurrencyRemoteDataSource.swift
//  CryptoRank
//
//  Created by Tamás Csató on 05/08/2024.
//

import Foundation

class CurrencyRemoteDataSource: CurrencyRemoteDataSourceProtocol {
    let baseURL = URL(string: "https://api.coincap.io/v2")!
    
    private func fetchData<T: Decodable>(from endpoint: String, queryItems: [URLQueryItem] = []) async throws -> T {
        var components = URLComponents(url: baseURL.appendingPathComponent(endpoint), resolvingAgainstBaseURL: false)!
        
        components.queryItems = queryItems
        
        let url = components.url!
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw AppError.unknown
            }
            
            guard httpResponse.statusCode == 200 else {
                throw AppError.badServerResponse(statusCode: httpResponse.statusCode)
            }
            
            let decoder = JSONDecoder()
            do {
                return try decoder.decode(T.self, from: data)
            } catch {
                throw AppError.decodingError
            }
        } catch {
            throw AppError.unknown
        }
    }
    
    func fetchTop10Assets() async throws -> AssetsResponse {
        return try await fetchData(from: "/assets", queryItems: [URLQueryItem(name: "limit", value: "10")])
    }
    
    func fetchAssetDetailForId(_ id: String) async throws -> AssetDetailResponse {
        return try await fetchData(from: "/assets/\(id)")
    }
}
