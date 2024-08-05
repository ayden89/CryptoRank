//
//  Error+AppError.swift
//  CryptoRank
//
//  Created by Tamás Csató on 05/08/2024.
//

import Foundation

extension Error {
    func appError() -> AppError {
        if let error = self as? AppError {
            return error
        }
      
        return AppError.unknown
    }
}
