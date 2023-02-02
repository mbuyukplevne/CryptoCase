//
//  CoinTableViewCell.swift
//  CryptoCase
//
//  Created by Mehdican Büyükplevne on 31.01.2023.
//

import UIKit
import SDWebImageSVGCoder

class CoinTableViewCell: UITableViewCell {
        
        // MARK: - Variables
        @IBOutlet weak var iconImageView: UIImageView!
        @IBOutlet weak var symbolLabel: UILabel!
        @IBOutlet weak var nameLabel: UILabel!
        @IBOutlet weak var priceLabel: UILabel!
        @IBOutlet weak var volumeLabel: UILabel!
        @IBOutlet weak var changeLabel: UILabel!
        var viewModel: CryptoListViewModel!
        
        // MARK: - Configure Cell
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
            
            // MARK: - Volume
            if let priceValue = Double(model.price!), let changeValue = Double(model.change!) {
                let result = priceValue * changeValue
                let roundResult = (result).rounded() / 100
                volumeLabel.text = String(roundResult)
            }
            
            // MARK: - Image
            let url = URL(string: model.iconURL ?? "")
            SDImageCodersManager.shared.addCoder(SDImageSVGCoder.shared)
            iconImageView.sd_setImage(with: url, completed: nil)
        }
    }
