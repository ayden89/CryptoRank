//
//  TopCurrencyListViewModel.swift
//  CryptoRank
//
//  Created by Tamás Csató on 05/08/2024.
//

import Foundation

final class TopCurrencyListViewModel: TopCurrencyListViewModelProtocol {
    @Published var currencyListState: ViewElementState<[AssetItem]> = .notRequested
    
    private let currencyRepository: CurrencyRepositoryProtocol
    
    init(currencyRepository: CurrencyRepositoryProtocol) {
        self.currencyRepository = currencyRepository
    }
    
    func onAppear() {
        fetchData()
    }
    
    func handleRetryButtonTap() {
        fetchData()
    }
    
    private func fetchData() {
        
    }
}
