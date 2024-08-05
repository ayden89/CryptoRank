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
        Task {
            await MainActor.run { [weak self] in
                guard let self else { return }
                
                currencyListState = .loading(isFirstLoad: currencyListState == .notRequested)
            }
            
            do {
                let result = try await currencyRepository.fetchTop10AssetsAscending()
                
                await MainActor.run { [weak self] in
                    guard let self else { return }
                    
                    currencyListState = .loaded(result)
                }
            } catch {
                await MainActor.run { [weak self] in
                    guard let self else { return }
                    
                    currencyListState = .error(error.appError())
                }
            }
            
        }
    }
}
