//
//  ErrorView.swift
//  CryptoRank
//
//  Created by Tamás Csató on 05/08/2024.
//

import SwiftUI

struct ErrorView: View {
    let onRetry: () -> Void
    
    var body: some View {
        VStack(spacing: 12) {
            Text("view.error.title.main")
                .textCase(.uppercase)
                .font(.system(size: 16,
                              weight: .bold))
                .foregroundStyle(.black)
            
            Button(action: {
                onRetry()
            }, label: {
                Text("view.error.title.button.retry")
                    .textCase(.uppercase)
                    .font(.system(size: 16,
                                  weight: .bold))
                    .foregroundColor(Color.white)
                    .frame(minHeight: 50)
                    .padding(.horizontal, 16)
            })
            .frame(minHeight: 50)
            .background(.black)
            .clipped()
        }
    }
}

#Preview {
    ErrorView(onRetry: {})
}
