//
//  Error+Extension.swift
//  VoltRates
//
//  Created by Dulatheo on 6/24/20.
//  Copyright © 2020 VoltMobi. All rights reserved.
//

import Foundation
extension Error {
    public func handleError() -> String? {
        return self.localizedDescription
    }
}
