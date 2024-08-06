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
            return String(localized: LocalizedStringResource("general.error.title.badServerResponse.\(statusCode)"))
        case .decodingError:
            return String(localized: LocalizedStringResource(stringLiteral: "general.error.title.decodingError"))
        case .unknown:
            return String(localized: LocalizedStringResource(stringLiteral: "general.error.title.unknown"))
        }
    }
}
