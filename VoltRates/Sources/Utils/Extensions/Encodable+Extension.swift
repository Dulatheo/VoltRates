//
//  Encodable+Extension.swift
//  VoltRates
//
//  Created by Dulatheo on 6/25/20.
//  Copyright © 2020 VoltMobi. All rights reserved.
//

import Foundation
import UIKit

extension Encodable {
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}
