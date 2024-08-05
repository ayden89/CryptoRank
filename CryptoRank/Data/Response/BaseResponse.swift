//
//  AssetsResponse.swift
//  CryptoRank
//
//  Created by Tamás Csató on 05/08/2024.
//

import Foundation

struct BaseResponse<T: Decodable>: Decodable {
    let data: T
    let timestamp: Double
}
