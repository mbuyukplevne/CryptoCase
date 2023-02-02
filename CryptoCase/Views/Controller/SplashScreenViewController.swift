//
//  SplashScreenViewController.swift
//  CryptoCase
//
//  Created by Mehdican Büyükplevne on 1.02.2023.
//

import UIKit

class SplashScreenViewController: UIViewController {

    @IBOutlet weak var logoImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let logoGif = UIImage.gifImageWithName("cryptos1")
        logoImageView.image = logoGif
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self.performSegue(withIdentifier: "toMainScreen", sender: nil)
        }

    }
    


}
