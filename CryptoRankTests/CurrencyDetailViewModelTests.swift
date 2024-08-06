//
//  CurrencyDetailViewModelTests.swift
//  CryptoRankTests
//
//  Created by Tamás Csató on 06/08/2024.
//

import XCTest
import Combine
@testable import CryptoRank

final class CurrencyDetailViewModelTests: XCTestCase {
    var sut: CurrencyDetailViewModel!
    var mockCurrencyRepository: MockCurrencyRepository!
    var cancellables = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        mockCurrencyRepository = MockCurrencyRepository()
        
        sut = CurrencyDetailViewModel(currencyRepository: mockCurrencyRepository,
                                      params: CurrencyDetailParams(item: AssetItem(id: "1",
                                                                                   rank: 1,
                                                                                   symbol: "example",
                                                                                   name: "example",
                                                                                   supply: 1.1,
                                                                                   maxSupply: 1.1,
                                                                                   marketCapInUsd: 1.1,
                                                                                   volumeInUsdLast24Hr: 1.1,
                                                                                   priceInUsd: 1.1,
                                                                                   changePercentLast24Hr: 1.1,
                                                                                   vwapLast24Hr: 1.1)))
        cancellables = Set<AnyCancellable>()
    }

    override func tearDownWithError() throws {
        mockCurrencyRepository = nil
        sut = nil
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
    }

    func testWhenHasItemShouldMoveToLoadedState() throws {
        let loadingWithPreviousDataExpectation = XCTestExpectation(description: "Moves to loadingWithPreviousData state")
        let loadedExpectation = XCTestExpectation(description: "Moves to loaded state")
        
        mockCurrencyRepository.assetItems = [AssetItem(id: "1",
                                                       rank: 1,
                                                       symbol: "example",
                                                       name: "example",
                                                       supply: 1.1,
                                                       maxSupply: 1.1,
                                                       marketCapInUsd: 1.1,
                                                       volumeInUsdLast24Hr: 1.1,
                                                       priceInUsd: 1.1,
                                                       changePercentLast24Hr: 1.1,
                                                       vwapLast24Hr: 1.1)]
        mockCurrencyRepository.errorToThrow = nil
        
        sut.$currencyDetailState
            .sink { state in
                switch state {
                case .loadingWithPreviousData:
                    loadingWithPreviousDataExpectation.fulfill()
                case .loaded:
                    loadedExpectation.fulfill()
                default:
                    break
                }
            }.store(in: &cancellables)
        
        sut.onAppear()
        
        wait(for: [loadingWithPreviousDataExpectation,
                   loadedExpectation],
             timeout: 1.0)
    }
    
    func testWhenHasErrorShouldMoveToErrorState() throws {
        let loadingWithPreviousDataExpectation = XCTestExpectation(description: "Moves to loadingWithPreviousData state")
        let errorExpectation = XCTestExpectation(description: "Moves to error state")

        let errorToThrow = AppError.badServerResponse(statusCode: 400)
        
        mockCurrencyRepository.assetItems = []
        mockCurrencyRepository.errorToThrow = errorToThrow
        
        sut.$currencyDetailState
            .sink { state in
                switch state {
                case .loadingWithPreviousData:
                    loadingWithPreviousDataExpectation.fulfill()
                case .error(let error):
                    XCTAssertEqual(error, errorToThrow)
                    errorExpectation.fulfill()
                default:
                    break
                }
            }.store(in: &cancellables)
        
        sut.onAppear()
        
        wait(for: [loadingWithPreviousDataExpectation,
                   errorExpectation],
             timeout: 1.0)
    }
}
