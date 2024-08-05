//
//  CurrencyDetailView.swift
//  CryptoRank
//
//  Created by Tamás Csató on 05/08/2024.
//


import SwiftUI

struct CurrencyDetailView<T: CurrencyDetailViewModelProtocol>: View {
    @StateObject var viewModel: T
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [.aquamarine.opacity(0.3),
                                                .vividBlue.opacity(0.3)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 0) {
                    Text("topCurrency.title.main")
                        .font(Font.custom("Poppins-Bold", size: 32.0))
                        .textCase(.uppercase)
                        .padding(16.0)
                    ZStack {
                        switch viewModel.currencyDetailState {
                        case .loading, .notRequested:
                            loadingView()
                        case .loadingWithPreviousData(let data):
                            ZStack {
                                loadingView()
                                detailView(item: data)
                            }
                        case .loaded(let data):
                            detailView(item: data)
                        case .error:
                            errorView(onRetry: viewModel.handleRetryButtonTap)
                        }
                    }
                    .frame(maxHeight: .infinity)
                    
                }
            }
        }
        .onAppear(perform: {
            viewModel.onAppear()
        })
    }
}

#Preview {
    CurrencyDetailView(viewModel: PreviewCurrencyDetailViewModel())
}

final class PreviewCurrencyDetailViewModel: CurrencyDetailViewModelProtocol {
    var currencyDetailState: ViewElementState<AssetItem> = .notRequested
    
    func onAppear() { }
    func handleRetryButtonTap() { }
}

extension CurrencyDetailView {
    func detailView(item: AssetItem) -> some View {
        ZStack {
            VStack(spacing: 16) {
                detailItemView(titleKey: String(localized: LocalizedStringResource(stringLiteral: "currencyDetail.title.price")),
                               value: item.formattedPriceInUsd)
                detailItemView(titleKey: String(localized: LocalizedStringResource(stringLiteral: "currencyDetail.title.change24hour")),
                               value: item.formattedChangePercentLast24Hr,
                               valueColor: item.last24ChangeType.color)
                
                Divider()
                    .background(.oceanBlue)
                    .frame(minHeight: 24)
                
                detailItemView(titleKey: String(localized: LocalizedStringResource(stringLiteral: "currencyDetail.title.marketCap")),
                               value: item.formattedMarketCap)
                detailItemView(titleKey: String(localized: LocalizedStringResource(stringLiteral: "currencyDetail.title.volume24hour")),
                               value: item.formattedVolumeInUsdLast24Hr)
                detailItemView(titleKey: String(localized: LocalizedStringResource(stringLiteral: "currencyDetail.title.supply")),
                               value: item.formattedSupply)
                
                Spacer()
            }
            .padding(24)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.white.opacity(0.4))
        .padding(16)
    }
}

extension CurrencyDetailView {
    func detailItemView(titleKey: String, value: String, valueColor: Color = .balticSea) -> some View {
        HStack {
            Text(titleKey)
                .font(Font.custom("Poppins-Regular", size: 16.0))
                .foregroundStyle(.balticSea)
            Spacer()
            Text(value)
                .font(Font.custom("Poppins-Bold", size: 16.0))
                .foregroundStyle(valueColor)
                .textCase(.uppercase)
        }
    }
}
