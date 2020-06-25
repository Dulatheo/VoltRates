//
//  String+Extension.swift
//  VoltRates
//
//  Created by Dulatheo on 6/24/20.
//  Copyright © 2020 VoltMobi. All rights reserved.
//

import Foundation
extension String {
    var localized:String {
        return NSLocalizedString(self, comment: "")
    }
    
    func pluralLocalized(_ count: Int, showCount:Bool = true) -> String {
        if showCount {
            return "\(count) " + String.localizedStringWithFormat(self.localized, count)
        }else{
            return String.localizedStringWithFormat(self.localized, count)
        }
    }
    
    var replaceDot: String {
        let result = self.replacingOccurrences(of: ".", with: ",")
        return result
    }
    
    var roundedDouble: String {
        if let rateAvg = Double(self) {
            let rateRounded = Double(round(1000*rateAvg)/1000)
            if floor(rateRounded) == rateRounded {
                return String(Int(rateRounded)).replaceDot
            }
            return String(rateRounded).replaceDot
        }
        
        return self
    }
}
