//
//  MainVC.swift
//  VoltRates
//
//  Created by Dulatheo on 6/23/20.
//  Copyright © 2020 VoltMobi. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class MainVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        view.backgroundColor = .white
    }
}

//MARK: - ConfigUI
extension MainVC {
    func configUI() {
        
        makeConstraints()
    }
    
    func makeConstraints() {
    }
}
