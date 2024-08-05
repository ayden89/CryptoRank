//
//  View+ErrorView.swift
//  CryptoRank
//
//  Created by Tamás Csató on 05/08/2024.
//

import SwiftUI

extension View {
    func errorView(onRetry: @escaping () -> Void) -> some View {
        ErrorView(onRetry: onRetry)
    }
}
