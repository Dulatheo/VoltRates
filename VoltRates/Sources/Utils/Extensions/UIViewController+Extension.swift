//
//  UIViewController+Extension.swift
//  VoltRates
//
//  Created by Dulatheo on 6/24/20.
//  Copyright © 2020 VoltMobi. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    var safeAreaPadding:UIEdgeInsets {
        if #available(iOS 11.0, *) {
            return UIApplication.shared.keyWindow?.safeAreaInsets ?? UIEdgeInsets.zero
        } else {
            return UIEdgeInsets.zero
        }
    }
}

extension UIViewController {
    public func openAlertError(title: String = "error", message: String? = nil, completion: (() -> Void)? = nil) {
        let alertVC = UIAlertController(title: title.localized, message: message, preferredStyle: .alert)
        
        if completion != nil {
            alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                completion!()
            }))
        }
        
        alertVC.addAction(UIAlertAction(title: "close".localized, style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
}
