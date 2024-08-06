//
//  CryptoRankTests.swift
//  CryptoRankTests
//
//  Created by Tamás Csató on 05/08/2024.
//

import XCTest
import Combine
@testable import CryptoRank

final class TopCurrencyListViewModelTests: XCTestCase {
    var sut: TopCurrencyListViewModel!
    var mockCurrencyRepository: MockCurrencyRepository!
    var cancellables = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        mockCurrencyRepository = MockCurrencyRepository()
        
        sut = TopCurrencyListViewModel(currencyRepository: mockCurrencyRepository)
        cancellables = Set<AnyCancellable>()
    }
    
    override func tearDownWithError() throws {
        mockCurrencyRepository = nil
        sut = nil
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
    }
    
    func testStateTransitionWhenHasItemShouldMoveToLoadedState() throws {
        let loadingExpectation = XCTestExpectation(description: "Moves to loading state")
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
        
        sut.$currencyListState
            .sink { state in
                switch state {
                case .loading:
                    loadingExpectation.fulfill()
                case .loaded(let data):
                    XCTAssert(!data.isEmpty)
                    loadedExpectation.fulfill()
                default:
                    break
                }
            }.store(in: &cancellables)
        
        sut.onAppear()
        
        wait(for: [loadingExpectation,
                   loadedExpectation],
             timeout: 1.0)
    }
    
    func testStateTransitionWhenHasNoItemShouldMoveToLoadedState() throws {
        let loadingExpectation = XCTestExpectation(description: "Moves to loading state")
        let loadedExpectation = XCTestExpectation(description: "Moves to loaded state")
        
        mockCurrencyRepository.assetItems = []
        mockCurrencyRepository.errorToThrow = nil
        
        sut.$currencyListState
            .sink { state in
                switch state {
                case .loading:
                    loadingExpectation.fulfill()
                case .loaded(let data):
                    XCTAssert(data.isEmpty)
                    loadedExpectation.fulfill()
                default:
                    break
                }
            }.store(in: &cancellables)
        
        sut.onAppear()
        
        wait(for: [loadingExpectation,
                   loadedExpectation],
             timeout: 1.0)
    }
    
    func testStateTransitionWhenHasErrorShouldMoveToErrorState() throws {
        let loadingExpectation = XCTestExpectation(description: "Moves to loading state")
        let errorExpectation = XCTestExpectation(description: "Moves to error state")

        let errorToThrow = AppError.badServerResponse(statusCode: 400)
        
        mockCurrencyRepository.assetItems = []
        mockCurrencyRepository.errorToThrow = errorToThrow
        
        sut.$currencyListState
            .sink { state in
                switch state {
                case .loading:
                    loadingExpectation.fulfill()
                case .error(let error):
                    XCTAssertEqual(error, errorToThrow)
                    errorExpectation.fulfill()
                default:
                    break
                }
            }.store(in: &cancellables)
        
        sut.onAppear()
        
        wait(for: [loadingExpectation,
                   errorExpectation],
             timeout: 1.0)
    }
}
