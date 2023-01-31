//
//  CoinTableViewCell.swift
//  CryptoCase
//
//  Created by Mehdican Büyükplevne on 31.01.2023.
//

import UIKit
import SDWebImageSVGCoder

class CoinTableViewCell: UITableViewCell {

        @IBOutlet weak var iconImageView: UIImageView!
        @IBOutlet weak var symbolLabel: UILabel!
        @IBOutlet weak var nameLabel: UILabel!
        @IBOutlet weak var priceLabel: UILabel!
        @IBOutlet weak var volumeLabel: UILabel!
        @IBOutlet weak var changeLabel: UILabel!
        var viewModel: CryptoListViewModel!
    
        func configCell(model: Coins) {
            symbolLabel.text = model.symbol
            nameLabel.text = model.name
            
            // MARK: - Price
            let originalPrice = Double(model.price!)
            let roundPrice = String(format: "%.2f", originalPrice!)
            priceLabel.text = "$\(roundPrice)"
            
            // MARK: - Change
            if let change = Double(model.change!) {
                changeLabel.text = model.change
                let changeColor = (change > 0) ? UIColor.systemGreen : UIColor.systemRed
                changeLabel.textColor = changeColor
            }
            
            if let priceValue = Double(model.price!), let changeValue = Double(model.change!) {
                let result = priceValue * changeValue
                let roundResult = (result).rounded() / 100
                volumeLabel.text = String(roundResult)
            }
//            symbolLabel.text = model.symbol
//            nameLabel.text = model.name
//            let price = NumberFormatter().number(from: model.price!)?.doubleValue ?? 0.0
//            let change = Double(model.change!) ?? 0.0
//            let priceChange = price * (change / 100)
//            changeLabel.text = "\(change)% (\(priceChange)$)"
//            let formatter = NumberFormatter()
//            formatter.minimumFractionDigits = 2
//            formatter.maximumFractionDigits = 2
//            priceLabel.text = "\(formatter.string(from: NSNumber(value: priceChange)) ?? "")"
//            changeLabel.text = "\(change)% ($\(formatter.string(from: NSNumber(value: priceChange)) ?? ""))"
//            if priceChange > 0 {
//                changeLabel.textColor = UIColor.systemGreen
//            } else {
//                changeLabel.textColor = UIColor.systemRed
//            }
    
            let url = URL(string: model.iconURL ?? "")
            SDImageCodersManager.shared.addCoder(SDImageSVGCoder.shared)
            iconImageView.sd_setImage(with: url, completed: nil)
        }
    }

