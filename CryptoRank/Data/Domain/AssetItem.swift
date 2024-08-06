//
//  AssetItem.swift
//  CryptoRank
//
//  Created by Tamás Csató on 05/08/2024.
//

import Foundation

struct AssetItem: Equatable, Identifiable {
    let id: String
    let rank: Int
    let symbol: String
    let name: String
    let supply: Double
    let maxSupply: Double?
    let marketCapInUsd: Double
    let volumeInUsdLast24Hr: Double
    let priceInUsd: Double
    let changePercentLast24Hr: Double
    let vwapLast24Hr: Double
    
    var iconImageUrl: URL? {
        return URL(string: "https://assets.coincap.io/assets/icons/\(symbol.lowercased())@2x.png")
    }
    
    var formattedPriceInUsd: String {
        return "$\(priceInUsd.abbreviationFormat())"
    }
    
    var formattedChangePercentLast24Hr: String {
        return String(format: "%.2f%%", changePercentLast24Hr)
    }
    
    var formattedMarketCap: String {
        return "$\(marketCapInUsd.abbreviationFormat())"
    }
    
    var formattedVolumeInUsdLast24Hr: String {
        return "$\(volumeInUsdLast24Hr.abbreviationFormat())"
    }
    
    var formattedSupply: String {
        return supply.abbreviationFormat()
    }
    
    var last24ChangeType: ChangeType {
        switch changePercentLast24Hr {
        case let x where x < 0:
            return .decreasing
        case let x where x > 0:
            return .increasing
        default:
            return .noChange
        }
    }
    
    init(id: String, rank: Int, symbol: String, name: String, supply: Double, maxSupply: Double?, marketCapInUsd: Double, volumeInUsdLast24Hr: Double, priceInUsd: Double, changePercentLast24Hr: Double, vwapLast24Hr: Double) {
        self.id = id
        self.rank = rank
        self.symbol = symbol
        self.name = name
        self.supply = supply
        self.maxSupply = maxSupply
        self.marketCapInUsd = marketCapInUsd
        self.volumeInUsdLast24Hr = volumeInUsdLast24Hr
        self.priceInUsd = priceInUsd
        self.changePercentLast24Hr = changePercentLast24Hr
        self.vwapLast24Hr = vwapLast24Hr
    }
    
    init?(from dto: AssetItemDTO) {
        guard
            let rank = Int(dto.rank),
            let supply = Double(dto.supply),
            let marketCapUsd = Double(dto.marketCapUsd),
            let volumeUsd24Hr = Double(dto.volumeUsd24Hr),
            let priceUsd = Double(dto.priceUsd),
            let changePercent24Hr = Double(dto.changePercent24Hr),
            let vwap24Hr = Double(dto.vwap24Hr)
        else {
            return nil
        }
        
        self.id = dto.id
        self.rank = rank
        self.symbol = dto.symbol
        self.name = dto.name
        self.supply = supply
        self.maxSupply = Double(dto.maxSupply ?? "")
        self.marketCapInUsd = marketCapUsd
        self.volumeInUsdLast24Hr = volumeUsd24Hr
        self.priceInUsd = priceUsd
        self.changePercentLast24Hr = changePercent24Hr
        self.vwapLast24Hr = vwap24Hr
    }
}
