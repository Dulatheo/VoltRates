//
//  UIFont+Extension.swift
//  VoltRates
//
//  Created by Dulatheo on 6/23/20.
//  Copyright © 2020 VoltMobi. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    static public func latoRegular(size: CGFloat) -> UIFont {
        return UIFont(name: "Lato-Regular", size: size)!
    }
    
    static public func latoBlack(size: CGFloat) -> UIFont {
        return UIFont(name: "Lato-Black", size: size)!
    }
    
    static public func latoMediumItalic(size: CGFloat) -> UIFont {
        return UIFont(name: "Lato-MediumItalic", size: size)!
    }
    
    static public func latoBold(size: CGFloat) -> UIFont {
        return UIFont(name: "Lato-Bold", size: size)!
    }
}
