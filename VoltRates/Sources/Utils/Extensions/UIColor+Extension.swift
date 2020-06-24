//
//  UIColor+Extension.swift
//  VoltRates
//
//  Created by Dulatheo on 6/24/20.
//  Copyright © 2020 VoltMobi. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    static func fromRgb(rgb:Int) -> UIColor{
        return UIColor(red: (CGFloat((rgb&0xFF0000) >> 16))/255.0, green: (CGFloat((rgb&0xFF00) >> 8))/255.0, blue: (CGFloat(rgb&0xFF))/255.0, alpha: 1.0)
    }
}
