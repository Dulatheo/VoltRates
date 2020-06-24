//
//  BottomView.swift
//  VoltRates
//
//  Created by Dulatheo on 6/24/20.
//  Copyright © 2020 VoltMobi. All rights reserved.
//

import Foundation
import UIKit

class BottomView: UIView {
    private let rateCell = "rateCell"
    
    open var onDidSelectRate: ((RateType) -> Void)?
    
    open var selectedRate: RateType = .RUBEUR
    open var rates: [RateType]  = [] {
        didSet {
            tableView.reloadData()
        }
    }
        
    fileprivate lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = .zero
        tableView.separatorColor = .black
        tableView.isScrollEnabled = false
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.backgroundColor = UIColor.fromRgb(rgb: 0x3F4753)
        
        tableView.register(RateCell.self, forCellReuseIdentifier: rateCell)
        
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - UITableView
extension BottomView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: rateCell, for: indexPath) as! RateCell
        let rate = rates[indexPath.row]
        cell.rate = rate
        cell.selected(rate == selectedRate)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rate = rates[indexPath.row]
        
        guard rate != selectedRate else { return }
        selectedRate = rate
        
        tableView.reloadData()
        
        if onDidSelectRate != nil {
            onDidSelectRate!(selectedRate)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88.0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}

//MARK: - ConfigUI
extension BottomView {
    private func configUI() {
        addSubview(tableView)
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        tableView.snp.makeConstraints { (m) in
            m.edges.equalToSuperview()
        }
    }
}
