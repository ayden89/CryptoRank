//
//  NetworkError.swift
//  CryptoRank
//
//  Created by Tamás Csató on 05/08/2024.
//

import Foundation

enum NetworkError: LocalizedError {
    case badServerResponse(statusCode: Int)
    case decodingError
    case unknown(Error)
    
    var errorDescription: String? {
        switch self {
        case .badServerResponse(let statusCode):
            return "Server responded with status code \(statusCode)."
        case .decodingError:
            return "Failed to decode the response."
        case .unknown(let error):
            return error.localizedDescription
        }
    }
}
