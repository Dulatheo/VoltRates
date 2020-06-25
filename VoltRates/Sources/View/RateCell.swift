//
//  RateCell.swift
//  VoltRates
//
//  Created by Dulatheo on 6/24/20.
//  Copyright © 2020 VoltMobi. All rights reserved.
//

import Foundation
import SnapKit
import UIKit

class RateCell: UITableViewCell {
    
    var rate: RateType? {
        didSet {
            guard let rate = rate else { return }
            
            titleLabel.text = rate.title
        }
    }

    fileprivate var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.latoRegular(size: 28)
        label.textColor = UIColor.white.withAlphaComponent(0.7)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Actions
extension RateCell {
    public func selected(_ selected: Bool) {
        titleLabel.font = selected ? UIFont.latoBlack(size: 28) : UIFont.latoRegular(size: 28)
        titleLabel.textColor = selected ? UIColor.white : UIColor.white.withAlphaComponent(0.7)
        backgroundColor = UIColor.mainColor
    }
}

//MARK: - ConfigUI
extension RateCell {
    private func configUI() {
        selectionStyle = .none
        
        addSubview(titleLabel)
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        titleLabel.snp.makeConstraints { (m) in
            m.center.equalToSuperview()
            m.height.equalTo(34)
        }
    }
}
