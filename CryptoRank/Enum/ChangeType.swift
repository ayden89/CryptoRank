//
//  ChangeType.swift
//  CryptoRank
//
//  Created by Tamás Csató on 05/08/2024.
//

import Foundation
import SwiftUI

enum ChangeType {
    case increasing
    case decreasing
    case noChange
    
    var color: Color {
        switch self {
        case .increasing:
            return .mintGreen
        case .decreasing:
            return .paleRed
        case .noChange:
            return .balticSea
        }
    }
}
