//
//  Double+AbbreviationFormat.swift
//  CryptoRank
//
//  Created by Tamás Csató on 05/08/2024.
//

import Foundation

extension Double {
    func abbreviationFormat() -> String {
        let absNumber = abs(self)
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.roundingMode = .halfUp
        
        if absNumber >= 1_000_000_000 {
            // Billion
            let billionValue = self / 1_000_000_000
            return "\(formatter.string(from: NSNumber(value: billionValue))!)B"
            
        } else if absNumber >= 1_000_000 {
            // Million
            let millionValue = self / 1_000_000
            return "\(formatter.string(from: NSNumber(value: millionValue))!)M"
            
        } else if absNumber >= 1_000 {
            // Thousand
            let thousandValue = self / 1_000
            return "\(formatter.string(from: NSNumber(value: thousandValue))!)K"
            
        } else {
            // Less than thousand
            return "\(formatter.string(from: NSNumber(value: self))!)"
        }
    }
}
