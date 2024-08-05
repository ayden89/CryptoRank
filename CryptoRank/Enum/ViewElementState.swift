//
//  ViewElementState.swift
//  CryptoRank
//
//  Created by Tamás Csató on 05/08/2024.
//

import Foundation

enum ViewElementState<T: Equatable>: Equatable {
    case loading(isFirstLoad: Bool)
    case loadingWithPreviousData(data: T)
    case loaded(data: T)
    case notRequested
    case error(AppError)
    
    var isLoading: Bool {
        if case .loading(_) = self {
            return true
        }
        
        return false
    }
    
    var isLoaded: Bool {
        if case .loaded(_) = self {
            return true
        }
        
        return false
    }
    
    var hasError: Bool {
        if case .error(_) = self {
            return true
        }
        
        return false
    }
}
