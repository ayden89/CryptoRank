//
//  TopCurrencyListContract.swift
//  CryptoRank
//
//  Created by Tamás Csató on 05/08/2024.
//

import Foundation

protocol TopCurrencyListViewModelProtocol: ObservableObject {
    var currencyListState: ViewElementState<[AssetItem]> { get }

    func onAppear()
    func handleRetryButtonTap()
    func handleListRefresh()
}
