//
//  TopCurrencyListView.swift
//  CryptoRank
//
//  Created by Tamás Csató on 05/08/2024.
//

import SwiftUI

struct TopCurrencyListView<T: TopCurrencyListViewModelProtocol>: View {
    @StateObject var viewModel: T

    var body: some View {
        NavigationStack {
            VStack {
                Text("")
                ZStack {
                    switch viewModel.currencyListState {
                    case .loading, .notRequested:
                        loadingView()
                    case .loaded(let data):
                        currencyListView(items: data)
                    case .error:
                        ErrorView(onRetry: viewModel.handleRetryButtonTap)
                    }
                }
            }
            
        }
        .onAppear(perform: {
            viewModel.onAppear()
        })
    }
}

#Preview {
    TopCurrencyListView(viewModel: PreviewTopCurrencyListViewModel())
}

final class PreviewTopCurrencyListViewModel: TopCurrencyListViewModelProtocol {
    var currencyListState: ViewElementState<[AssetItem]> = .notRequested
    
    func onAppear() { }
    func handleRetryButtonTap() { }
}

extension TopCurrencyListView {
    func currencyListView(items: [AssetItem]) -> some View {
        List {
            
        }
    }
}
 
