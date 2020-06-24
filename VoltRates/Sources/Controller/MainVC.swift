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
    
    private var rates: [RateType] = [.EURUSD, .EURRUB, .RUBEUR, .RUBUSD, .USDEUR, .USDRUB]
    
    private var selectedRate: RateType = .EURUSD
    
    fileprivate lazy var menuButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = UIColor.fromRgb(rgb: 0x4E5765)
        button.imageView?.contentMode = .center
        button.setImage(#imageLiteral(resourceName: "menu_button"), for: .normal)
        button.addTarget(self, action: #selector(menuClicked), for: .touchUpInside)
        return button
    }()
    
    fileprivate lazy var bottomView: BottomView = {
        let view = BottomView()
        view.rates = rates
        view.selectedRate = selectedRate
        view.onDidSelectRate = { [weak self] rate in
            guard let wSelf = self else { return }
            
            wSelf.selectedRate = rate
            wSelf.getLatestRates()
        }
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        getLatestRates()
    }
}

//MARK: - Requests
extension MainVC {
    private func getLatestRates() {
        NetworkLayer.shared.request(route: APIRouter.latest(base: selectedRate.from, currencies: [selectedRate.to]), { [weak self] (string: String?) in
            guard let wSelf = self else { return }
            
            
        }) { [weak self] (error) in
            guard let wSelf =  self else { return }
            
            wSelf.openAlertError(message: error?.handleError())
        }
    }
}

//MARK: - Actions
extension MainVC {
    @objc private func menuClicked() {
        bottomView.snp.updateConstraints { (m) in
            m.top.equalToSuperview().offset(UIScreen.main.bounds.height - (CGFloat(88 * rates.count) + self.safeAreaPadding.bottom))
        }
        
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func hideBottomView() {
        bottomView.snp.updateConstraints { (m) in
            m.top.equalToSuperview().offset(UIScreen.main.bounds.height)
        }
        
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch? = touches.first
        if touch?.view != bottomView {
            hideBottomView()
        }
    }
}

//MARK: - ConfigUI
extension MainVC {
    func configUI() {
        view.backgroundColor = .white
        
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
//        view.addGestureRecognizer(tapGesture)
//        view.backgroundColor = .white
        
        view.addSubview(menuButton)
        view.addSubview(bottomView)
        
        makeConstraints()
    }
    
    func makeConstraints() {
        menuButton.snp.makeConstraints { (m) in
            m.height.width.equalTo(44)
            m.left.equalToSuperview().offset(30)
            m.bottom.equalToSuperview().offset(-40 - self.safeAreaPadding.bottom)
        }
        
        bottomView.snp.makeConstraints { (m) in
            m.left.right.equalToSuperview()
            m.height.equalTo(CGFloat(88 * rates.count) + self.safeAreaPadding.bottom)
            m.top.equalToSuperview().offset(UIScreen.main.bounds.height)
        }
    }
}
