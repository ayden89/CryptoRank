//
//  CurrencyDetailViewModel.swift
//  CryptoRank
//
//  Created by Tamás Csató on 05/08/2024.
//

import Foundation

final class CurrencyDetailViewModel: CurrencyDetailViewModelProtocol {
    @Published var currencyDetailState: ViewElementState<AssetItem> = .notRequested
    
    private let currencyRepository: CurrencyRepositoryProtocol
    private let params: CurrencyDetailParams
    
    private var lastItem: AssetItem
    
    init(currencyRepository: CurrencyRepositoryProtocol, params: CurrencyDetailParams) {
        self.currencyRepository = currencyRepository
        self.params = params
        self.lastItem = params.item
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
                
                currencyDetailState = .loadingWithPreviousData(data: lastItem)
            }
            do {
                let result = try await currencyRepository.fetchAssetDetailForId(lastItem.id)
                
                await MainActor.run { [weak self] in
                    guard let self else { return }
                    
                    currencyDetailState = .loaded(data: result)
                }
            } catch {
                await MainActor.run { [weak self] in
                    guard let self else { return }
                    
                    currencyDetailState = .error(error.appError())
                }
            }
            
        }
    }
}
