//
//  RateType.swift
//  VoltRates
//
//  Created by Dulatheo on 6/24/20.
//  Copyright © 2020 VoltMobi. All rights reserved.
//

import Foundation

enum RateType {
    case RUBEUR
    case RUBUSD
    case EURRUB
    case EURUSD
    case USDRUB
    case USDEUR
}

extension RateType {
    var from: CurrencyType {
        switch self {
        case .RUBEUR, .RUBUSD:
            return .RUB
        case .EURRUB, .EURUSD:
            return .EUR
        case .USDEUR, .USDRUB:
            return .USD
        }
    }
    
    var to: CurrencyType {
        switch self {
        case .RUBEUR, .USDEUR:
            return .EUR
        case .EURRUB, .USDRUB:
            return .RUB
        case .RUBUSD, .EURUSD:
            return .USD
        }
    }
    
    var title: String {
        return "\(self.from) → \(self.to)"
    }
}
