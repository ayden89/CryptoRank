//
//  TopCurrencyListView.swift
//  CryptoRank
//
//  Created by Tamás Csató on 05/08/2024.
//

import SwiftUI
import Swinject

struct TopCurrencyListView<T: TopCurrencyListViewModelProtocol>: View {
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

                VStack(alignment: .leading,
                       spacing: 0) {
                    Text("topCurrency.title.main")
                        .font(Font.custom("Poppins-Bold", size: 32.0))
                        .textCase(.uppercase)
                        .padding(16.0)
                        .multilineTextAlignment(.leading)
                    ZStack {
                        switch viewModel.currencyListState {
                        case .loading, .notRequested, .loadingWithPreviousData:
                            loadingView()
                        case .loaded(let data):
                            currencyListView(items: data)
                        case .error:
                            errorView(onRetry: viewModel.handleRetryButtonTap)
                        }
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
            ForEach(items) { item in
                
                ZStack(content: {
                    currencyListItemView(item: item)

                    NavigationLink(destination: Container.currencyDetailContainer.resolve(CurrencyDetailView<CurrencyDetailViewModel>.self,
                                                                                          argument: CurrencyDetailParams(item: item))) {
                        EmptyView()
                    }
                    .buttonStyle(PlainButtonStyle())
                    .opacity(0)
                })
            }
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)
            .listRowInsets(.init(top: 8, leading: 16, bottom: 8, trailing: 16))
            .listSectionSeparator(.hidden)
        }
        .listStyle(.plain)
        .background(.clear)
    }
}

extension TopCurrencyListView {
    func currencyListItemView(item: AssetItem) -> some View {
        HStack(content: {
            VStack {
                AsyncImage(url: item.iconImageUrl,
                           content: { result in
                    result.image?
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 56, height: 56)
                })
                Spacer()
            }
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(Font.custom("Poppins-Bold", size: 20.0))
                    .textCase(.uppercase)
                Text(item.symbol)
                    .font(Font.custom("Poppins-Regular", size: 16.0))
                    .textCase(.uppercase)
                Spacer()
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text(item.formattedPriceInUsd)
                    .font(Font.custom("Poppins-Bold", size: 16.0))
                Text(item.formattedChangePercentLast24Hr)
                    .foregroundStyle(item.last24ChangeType.color)
                    .font(Font.custom("Poppins-Bold", size: 16.0))
                Image(.iconArrowRightBalticSea)
                    .resizable()
                    .frame(width: 16, height: 14)
            }
        })
        .padding(EdgeInsets(top: 16,
                            leading: 12,
                            bottom: 16,
                            trailing: 16))
        .frame(maxWidth: .infinity, minHeight: 50)
        .background(Color.white.opacity(0.4))
        .cornerRadius(16)
    }
}

