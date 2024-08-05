//
//  CryptoRankApp.swift
//  CryptoRank
//
//  Created by Tamás Csató on 05/08/2024.
//

import SwiftUI
import Swinject

@main
struct CryptoRankApp: App {
    var body: some Scene {
        WindowGroup {
            Container.topCurrencyListContainer.resolve(TopCurrencyListView<TopCurrencyListViewModel>.self)
        }
    }
}
