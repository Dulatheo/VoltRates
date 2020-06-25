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
    private var startDate = Date().before2Days.string(format: .withoutTimeDush)
    private var endDate = Date().dayBefore.string(format: .withoutTimeDush)
    
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
            Constants.isSmallDevice() ? wSelf.hideBottomView() : nil
        }
        return view
    }()
    
    fileprivate var updatedLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.latoBlack(size: 17)
        label.textColor = UIColor.mainColor.withAlphaComponent(0.4)
        return label
    }()
    
    fileprivate var rateView = RateView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        getLatestRates()
    }
}

//MARK: - Requests
extension MainVC {
    private func getLatestRates() {
        updating()
        
        var rateRequest = RateRequest()
        rateRequest.base = selectedRate.from
        rateRequest.symbols = selectedRate.to
        rateRequest.end_at = endDate
        rateRequest.start_at = startDate
        
        NetworkLayer.shared.request(route: APIRouter.history(rateRequest), { [weak self] (rate: Rate?) in
            guard let wSelf = self else { return }
            guard let rate = rate else { return }
            
            wSelf.updating(false)
            
            wSelf.rateView.setRate(selectedRate: wSelf.selectedRate, rate: rate, startDate: wSelf.startDate, endDate: wSelf.endDate)
            
        }) { [weak self] (error) in
            guard let wSelf =  self else { return }
            
            wSelf.updating(false)
            
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
        
        if !Constants.isSmallDevice() {
            rateView.snp.remakeConstraints { (m) in
                m.centerX.width.equalToSuperview()
                m.bottom.equalTo(bottomView.snp.top).offset(-12)
            }
        }

        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func hideBottomView() {
        bottomView.snp.updateConstraints { (m) in
            m.top.equalToSuperview().offset(UIScreen.main.bounds.height)
        }
        
        if !Constants.isSmallDevice() {
            rateView.snp.remakeConstraints { (m) in
                m.center.width.equalToSuperview()
            }
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
    
    private func updating(_ updating: Bool = true) {
        updatedLabel.text = !updating ? "\("updated_at".localized) \(Date().string(format: .onlyTime))".uppercased() : "updating".localized.uppercased()
    }
}

//MARK: - ConfigUI
extension MainVC {
    private func configUI() {
        view.backgroundColor = .white
        
        [menuButton, rateView, updatedLabel, bottomView].forEach {
            view.addSubview($0)
        }
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        menuButton.snp.makeConstraints { (m) in
            m.height.width.equalTo(44)
            m.left.equalToSuperview().offset(30)
            m.bottom.equalToSuperview().offset(-40 - self.safeAreaPadding.bottom)
        }
        
        updatedLabel.snp.makeConstraints { (m) in
            m.centerX.equalToSuperview()
            m.centerY.equalTo(menuButton)
        }
        
        rateView.snp.makeConstraints { (m) in
            m.center.width.equalToSuperview()
        }
        
        bottomView.snp.makeConstraints { (m) in
            m.left.right.equalToSuperview()
            m.height.equalTo(CGFloat(88 * rates.count) + self.safeAreaPadding.bottom)
            m.top.equalToSuperview().offset(UIScreen.main.bounds.height)
        }
    }
}
