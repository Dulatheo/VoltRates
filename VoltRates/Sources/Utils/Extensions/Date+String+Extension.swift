//
//  Date+String+Extension.swift
//  VoltRates
//
//  Created by Dulatheo on 6/25/20.
//  Copyright © 2020 VoltMobi. All rights reserved.
//

import Foundation
enum DateFormat: String {
    case withoutTimeDush = "yyyy-MM-dd"
    case onlyTime = "HH:mm"
}


extension String {
    func date() -> Date? {
        return date(format: .withoutTimeDush)
    }
    
    func date(format: DateFormat) -> Date? {
        var dateString = self
        dateString = dateString.replacingOccurrences(of: "\\.\\d+", with: "", options: .regularExpression)

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = format.rawValue
        let date = dateFormatter.date(from: dateString)
        return date
    }
    
    func dateString() -> String {
        return dateString(withFormat: .withoutTimeDush,
                          toFormat: .withoutTimeDush,
                          locale: "en_US_POSIX")
    }
    
    func dateString(withFormat: DateFormat, toFormat: DateFormat, locale: String?) -> String {
        let dateFormatter = DateFormatter()
        if locale != nil {
            dateFormatter.locale = Locale(identifier: locale!)
        }
        dateFormatter.timeZone = TimeZone.init(abbreviation: "UTC")
        dateFormatter.dateStyle = .long
        dateFormatter.dateFormat = withFormat.rawValue
        if let date = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = toFormat.rawValue
            let newSt = dateFormatter.string(from: date)
            return newSt
        }
        return ""
    }
}

extension Date {
    func string() -> String {
        return string(format: .withoutTimeDush)
    }
    
    func string(format: DateFormat) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        dateFormatter.locale = Locale.current
        let str = dateFormatter.string(from: self)
        return str
    }
    
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    
    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    
    var before2Days: Date {
        return Calendar.current.date(byAdding: .day, value: -2, to: noon)!
    }
}
