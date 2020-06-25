//
//  CurrencyType.swift
//  VoltRates
//
//  Created by Dulatheo on 6/24/20.
//  Copyright © 2020 VoltMobi. All rights reserved.
//

import Foundation

enum CurrencyType: String, Codable {
    case RUB = "RUB"
    case USD = "USD"
    case EUR = "EUR"
}

extension CurrencyType {
    var name: String {
        return self.rawValue.localized
    }
}
