//
//  NetworkError.swift
//  CryptoRank
//
//  Created by Tamás Csató on 05/08/2024.
//

import Foundation

enum AppError: LocalizedError, Equatable {
    case badServerResponse(statusCode: Int)
    case decodingError
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .badServerResponse(let statusCode):
            return "Server responded with status code \(statusCode)."
        case .decodingError:
            return "Failed to decode the response."
        case .unknown:
            return "Unknown error occurred."
        }
    }
}
