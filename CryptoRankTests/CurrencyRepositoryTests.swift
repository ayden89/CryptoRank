//
//  CurrencyRepositoryTests.swift
//  CryptoRankTests
//
//  Created by Tamás Csató on 06/08/2024.
//

import XCTest
@testable import CryptoRank

final class CurrencyRepositoryTests: XCTestCase {
    var sut: CurrencyRepository!
    var mockRemoteDataSource: MockRemoteDataSource!
    
    override func setUpWithError() throws {
        mockRemoteDataSource = MockRemoteDataSource()
        sut = CurrencyRepository(remoteDataSource: mockRemoteDataSource)
    }
    
    override func tearDownWithError() throws {
        mockRemoteDataSource = nil
        sut = nil
    }
    
    func testFetchTopTenWhenAllDTOValidShouldItemCountMatch() throws {
        let resultExpectation = XCTestExpectation(description: "Item count matches")
        
        let dtos = [AssetItemDTO(id: "1",
                                 rank: "1",
                                 symbol: "example",
                                 name: "example",
                                 supply: "10.0",
                                 maxSupply: nil,
                                 marketCapUsd: "10.0",
                                 volumeUsd24Hr: "10.0",
                                 priceUsd: "10.0",
                                 changePercent24Hr: "10.0",
                                 vwap24Hr: "10.0"),
                    AssetItemDTO(id: "2",
                                 rank: "2",
                                 symbol: "example",
                                 name: "example",
                                 supply: "20.0",
                                 maxSupply: nil,
                                 marketCapUsd: "20.0",
                                 volumeUsd24Hr: "20.0",
                                 priceUsd: "20.0",
                                 changePercent24Hr: "20.0",
                                 vwap24Hr: "20.0")]
        
        mockRemoteDataSource.assetItemDTOs = dtos
        
        Task {
            let result = try await sut.fetchTop10AssetsAscending()
            XCTAssertEqual(dtos.count,
                           result.count,
                           "DTO and domain model result count not matching.")
            resultExpectation.fulfill()
            
        }
        
        wait(for: [resultExpectation],
             timeout: 1.0)
    }
    
    func testFetchTopTenWhenHasOneInvalidDTOShouldItemCountLessByOne() throws {
        let resultExpectation = XCTestExpectation(description: "Item count matches")
        
        let dtos = [AssetItemDTO(id: "1",
                                 rank: "1",
                                 symbol: "example",
                                 name: "example",
                                 supply: "10.0",
                                 maxSupply: nil,
                                 marketCapUsd: "10.0",
                                 volumeUsd24Hr: "10.0",
                                 priceUsd: "10.0",
                                 changePercent24Hr: "10.0",
                                 vwap24Hr: "10.0"),
                    AssetItemDTO(id: "2",
                                 rank: "2",
                                 symbol: "example",
                                 name: "example",
                                 supply: "20.0",
                                 maxSupply: nil,
                                 marketCapUsd: "invalidMarketCap20.0",
                                 volumeUsd24Hr: "20.0",
                                 priceUsd: "20.0",
                                 changePercent24Hr: "20.0",
                                 vwap24Hr: "20.0"),
                    AssetItemDTO(id: "3",
                                 rank: "3",
                                 symbol: "example",
                                 name: "example",
                                 supply: "30.0",
                                 maxSupply: nil,
                                 marketCapUsd: "30.0",
                                 volumeUsd24Hr: "30.0",
                                 priceUsd: "30.0",
                                 changePercent24Hr: "30.0",
                                 vwap24Hr: "30.0")]
        
        mockRemoteDataSource.assetItemDTOs = dtos
        
        Task {
            let result = try await sut.fetchTop10AssetsAscending()
            let expectedCount = dtos.count - 1 // Subtracting one because the dto with id "2" is invalid
            
            XCTAssertEqual(expectedCount,
                           result.count,
                           "Domain model count should be less than DTO count by exactly one.")
            resultExpectation.fulfill()
            
        }
        
        wait(for: [resultExpectation],
             timeout: 1.0)
    }
    
    func testFetchDetailWhenIdIsValidShouldReturnItem() throws {
        let resultExpectation = XCTestExpectation(description: "Returns valid item.")
        
        let dtos = [AssetItemDTO(id: "1",
                                 rank: "1",
                                 symbol: "example",
                                 name: "example",
                                 supply: "10.0",
                                 maxSupply: nil,
                                 marketCapUsd: "10.0",
                                 volumeUsd24Hr: "10.0",
                                 priceUsd: "10.0",
                                 changePercent24Hr: "10.0",
                                 vwap24Hr: "10.0")]
        
        mockRemoteDataSource.assetItemDTOs = dtos
        
        Task {
            let id = "1"
            let result = try await sut.fetchAssetDetailForId(id)
            
            XCTAssertEqual(result.id,
                           id,
                           "Can't fetch item by valid id from data source.")
            resultExpectation.fulfill()
        }
        
        wait(for: [resultExpectation],
             timeout: 1.0)
    }
    
    func testFetchDetailWhenIdIsInvalidShouldThrowError() throws {
        let resultExpectation = XCTestExpectation(description: "Returns valid item.")
        
        let dtos = [AssetItemDTO(id: "1",
                                 rank: "1",
                                 symbol: "example",
                                 name: "example",
                                 supply: "10.0",
                                 maxSupply: nil,
                                 marketCapUsd: "10.0",
                                 volumeUsd24Hr: "10.0",
                                 priceUsd: "10.0",
                                 changePercent24Hr: "10.0",
                                 vwap24Hr: "10.0")]
        
        mockRemoteDataSource.assetItemDTOs = dtos
        
        Task {
            let id = "2"
            do {
                _ = try await sut.fetchAssetDetailForId(id)
            } catch {
                resultExpectation.fulfill()
            }
        }
        
        wait(for: [resultExpectation],
             timeout: 1.0)
    }
    
    func testFetchDetailWhenDTPIsInvalidShouldReturnItem() throws {
        let resultExpectation = XCTestExpectation(description: "Throws error.")
        
        let dtos = [AssetItemDTO(id: "1",
                                 rank: "1",
                                 symbol: "example",
                                 name: "example",
                                 supply: "invalid item 10.0",
                                 maxSupply: nil,
                                 marketCapUsd: "10.0",
                                 volumeUsd24Hr: "10.0",
                                 priceUsd: "10.0",
                                 changePercent24Hr: "10.0",
                                 vwap24Hr: "10.0")]
        
        mockRemoteDataSource.assetItemDTOs = dtos
        
        Task {
            let id = "1"
            do {
                _ = try await sut.fetchAssetDetailForId(id)
            } catch {
                resultExpectation.fulfill()
            }
        }
        
        wait(for: [resultExpectation],
             timeout: 1.0)
    }
}
