//
//  RateView.swift
//  VoltRates
//
//  Created by Dulatheo on 6/25/20.
//  Copyright © 2020 VoltMobi. All rights reserved.
//

import Foundation
import UIKit

class RateView: UIView {
    
    fileprivate var currencyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.latoBold(size: 17)
        label.textColor = UIColor.mainColor.withAlphaComponent(0.7)
        label.textAlignment = .center
        return label
    }()
    
    fileprivate var rateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.latoRegular(size: 80)
        label.textColor = UIColor.mainColor
        label.textAlignment = .center
        return label
    }()
    
    fileprivate var infoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.latoMediumItalic(size: 17)
        label.textColor = UIColor.mainColor
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Methods
extension RateView {
    public func setRate(selectedRate: RateType, rate: Rate, startDate: String, endDate: String) {
        if let startDateRate = rate.rates?[startDate]?[selectedRate.to.rawValue], let endRateDate = rate.rates?[endDate]?[selectedRate.to.rawValue] {

            var result = 100.0 * startDateRate/endRateDate
            result = 100.0 - result
            
            var text = "rate_zero".localized
            
            let percent = Int(result)
            if percent > 0 {
                infoLabel.textColor = UIColor.greenUp
                var rateString = "rate_up".localized + "plural_percent".pluralLocalized(percent)
                rateString = rateString.replacingOccurrences(of: "@", with: selectedRate.from.name)
                text = rateString
            }else if percent < 0 {
                infoLabel.textColor = UIColor.redDown
                var rateString = "rate_down".localized + "plural_percent".pluralLocalized(percent)
                rateString = rateString.replacingOccurrences(of: "@", with: selectedRate.from.name)
                text = rateString
            }
            infoLabel.text = text
        }
        
        if let endRateDate = rate.rates?[endDate]?[selectedRate.to.rawValue] {
            UIView.transition(with: rateLabel,
                 duration: 0.25,
                  options: .transitionCrossDissolve,
               animations: { [unowned self] in
                self.rateLabel.text = String(endRateDate).roundedDouble
            }, completion: nil)
        }
        currencyLabel.text = selectedRate.title
    }
}

//MARK: - ConfigUI
extension RateView {
    private func configUI() {
        
        [currencyLabel, rateLabel, infoLabel].forEach {
            addSubview($0)
        }
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        currencyLabel.snp.makeConstraints { (m) in
            m.centerX.top.equalToSuperview()
            m.width.equalToSuperview().offset(-16)
        }
        
        rateLabel.snp.makeConstraints { (m) in
            m.top.equalTo(currencyLabel.snp.bottom)
            m.centerX.equalToSuperview()
            m.width.equalToSuperview().offset(-4)
        }
        
        infoLabel.snp.makeConstraints { (m) in
            m.centerX.equalToSuperview()
            m.width.equalToSuperview().offset(-64)
            m.top.equalTo(rateLabel.snp.bottom).offset(12)
            m.bottom.equalToSuperview()
        }
    }
}
