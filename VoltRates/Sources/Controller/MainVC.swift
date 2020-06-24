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
        getLatestRates()
        view.backgroundColor = .white
    }
}

//MARK: - Requests
extension MainVC {
    private func getLatestRates() {
        NetworkLayer.shared.request(route: APIRouter.latest(base: .RUB, currencies: [.EUR, .RUB, .USD]), { [weak self] (string: String?) in
            guard let wSelf = self else { return }
        }) { [weak self] (error) in
            guard let wSelf =  self else { return }
            
            wSelf.openAlertError(message: error?.handleError())
        }
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
