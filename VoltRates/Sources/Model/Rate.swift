//
//  Rate.swift
//  VoltRates
//
//  Created by Dulatheo on 6/25/20.
//  Copyright © 2020 VoltMobi. All rights reserved.
//

import Foundation
struct Rate: Codable {
    var rates: [String: [String : Double]]?
    var base: CurrencyType?
    var start_at, end_at: String?
}
