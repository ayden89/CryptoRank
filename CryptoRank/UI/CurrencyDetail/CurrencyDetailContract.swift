//
//  CurrencyDetailContract.swift
//  CryptoRank
//
//  Created by Tamás Csató on 05/08/2024.
//

import Foundation

struct CurrencyDetailParams {
    let item: AssetItem
}

protocol CurrencyDetailViewModelProtocol: ObservableObject {
    var currencyDetailState: ViewElementState<AssetItem> { get }

    func onAppear()
    func handleRetryButtonTap()
}
