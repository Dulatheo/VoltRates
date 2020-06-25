//
//  Constants.swift
//  VoltRates
//
//  Created by Dulatheo on 6/24/20.
//  Copyright © 2020 VoltMobi. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    //URLS
    static let url = "https://api.exchangeratesapi.io"
    
    static func baseUrl() -> String {
        return url
    }
    
    static func isSmallDevice() -> Bool {
        if UIScreen.main.bounds.height <= 568.0 {
            return true
        }
        return false
    }
}
