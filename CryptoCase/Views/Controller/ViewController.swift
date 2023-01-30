//
//  ViewController.swift
//  CryptoCase
//
//  Created by Mehdican Büyükplevne on 28.01.2023.
//

import UIKit

class ViewController: UIViewController {
    
    let identifier = "cell"

    @IBOutlet weak var sortButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: CryptoListViewModel?
    var selectedTitle: String?
    let menuView = UIView(frame: CGRect(x: 260, y: 100, width: 140, height: 150))
    let priceButton = UIButton(frame: CGRect(x: 20, y: 50, width: 100, height: 20))
    let marketCapButton = UIButton(frame: CGRect(x: 20, y: 20, width: 100, height: 20))
    let changeButton = UIButton(frame: CGRect(x: 20, y: 80, width: 100, height: 20))
    let the24hVolume = UIButton(frame: CGRect(x: 20, y: 110, width: 100, height: 20))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        tableView.delegate = self
        tableView.dataSource = self
        menuView.layer.cornerRadius = 20
        menuView.layer.masksToBounds = true
        view.addSubview(menuView)
        menuView.backgroundColor = .systemGreen
        menuView.isHidden = true
        the24hVolume.backgroundColor = .clear
        the24hVolume.setTitle("24h Vol", for: .normal)
        the24hVolume.addTarget(self, action: #selector(sortBy24hVol), for: .touchUpInside)
        priceButton.backgroundColor = .clear
        priceButton.setTitle("Price", for: .normal)
        priceButton.addTarget(self, action: #selector(sortByPrice), for: .touchUpInside)
        changeButton.backgroundColor = .clear
        changeButton.setTitle("Change", for: .normal)
        changeButton.addTarget(self, action: #selector(sortByChange), for: .touchUpInside)
        marketCapButton.backgroundColor = .clear
        marketCapButton.setTitle("Market Cap", for: .normal)
        marketCapButton.setTitleColor(UIColor.black, for: .normal)
        marketCapButton.addTarget(self, action: #selector(sortByMarketCap), for: .touchUpInside)
        menuView.addSubview(the24hVolume)
        menuView.addSubview(priceButton)
        menuView.addSubview(changeButton)
        menuView.addSubview(marketCapButton)
        
        
        viewModel = CryptoListViewModel(APIService: APICallService(service: APICaller()))
        guard let viewModel = viewModel else {return}
        viewModel.getCrypto {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func registerCell() {
        tableView.register(UINib(nibName: "CryptoTableViewCell", bundle: nil), forCellReuseIdentifier: identifier)
        
    }
    
    @objc func sortBy24hVol() {
        guard let viewModel = self.viewModel else {return}
        viewModel.cryptoList?.coins!.sort{ (coinOne, CoinTwo) -> Bool in
            return coinOne.the24HVolume! < CoinTwo.the24HVolume!
        }
        DispatchQueue.main.async { [self] in
            self.tableView.reloadData()
            menuView.isHidden = true
        }
    }
    
    @objc func sortByPrice() {
        guard let viewModel = self.viewModel else {return}
        viewModel.cryptoList?.coins!.sort { (coinOne, coinTwo) -> Bool in
            return coinOne.price! < coinTwo.price!
        }
        DispatchQueue.main.async { [self] in
            self.tableView.reloadData()
            menuView.isHidden = true
        }
    }
    
    @objc func sortByChange() {
        guard let viewModel = self.viewModel else {return}
        viewModel.cryptoList?.coins!.sort{ (coinOne, coinTwo) -> Bool in
            return coinOne.change! < coinTwo.change!
        }
        
        DispatchQueue.main.async { [self] in
            self.tableView.reloadData()
            menuView.isHidden = true
        }
    }
    
    @objc func sortByMarketCap() {
        guard let viewModel = self.viewModel else {return}
        viewModel.cryptoList?.coins!.sort { (coinOne, coinTwo) -> Bool in
            return coinOne.marketCap! < coinTwo.marketCap!
        }
        DispatchQueue.main.async { [self] in
            self.tableView.reloadData()
            menuView.isHidden = true
        }
    }
    
    @IBAction func sortButtonTapped(_ sender: UIButton) {
        if menuView.isHidden {
            menuView.isHidden = false
        } else {
            menuView.isHidden = true
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.cryptoList?.coins?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! CryptoTableViewCell
        let model = viewModel?.cryptoList?.coins![indexPath.section]
        cell.configCell(model: model!)
        return cell
    }
}



