//
//  DetailViewController.swift
//  CryptoCase
//
//  Created by Mehdican Büyükplevne on 31.01.2023.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: - Variables
    var model: Coins?
    
    // MARK: - Outlets
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var lowLabel: UILabel!
    @IBOutlet weak var highLabel: UILabel!
    @IBOutlet weak var volumeLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure(model: model)

    }
    
    func configure(model: Coins!) {
        if let model = self.model {
            let originalValue = Double(model.price ?? "1")
            let roundValue = String(format: "%.2f", originalValue!)
            priceLabel.text = "$\(roundValue)"
        }
        
        
        if let priceVolume = Double((model.price!)), let changeValue = Double((model.change!)) {
            let result = priceVolume * changeValue
            let roundResult = (result).rounded() / 100
            volumeLabel.text = String(roundResult)
        }
    }
}


