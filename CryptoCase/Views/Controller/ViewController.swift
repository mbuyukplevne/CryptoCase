//
//  ViewController.swift
//  CryptoCase
//
//  Created by Mehdican Büyükplevne on 28.01.2023.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Identifier
    let identifier = "cell"
    
    // MARK: - Outlets
    @IBOutlet weak var sortButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables
    var viewModel: CryptoListViewModel?
    var selectedTitle: String?
    let menuView = UIView(frame: CGRect(x: 310, y: 125, width: 100, height: 150))
    let priceButton = UIButton(frame: CGRect(x: 20, y: 50, width: 50, height: 20))
    let marketCapButton = UIButton(frame: CGRect(x: 0, y: 20, width: 100, height: 20))
    let changeButton = UIButton(frame: CGRect(x: 0, y: 80, width: 100, height: 20))
    let the24hVolume = UIButton(frame: CGRect(x: 0, y: 110, width: 100, height: 20))
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        registerCell()
        tableView.delegate = self
        tableView.dataSource = self
        menuView.layer.cornerRadius = 20
        menuView.layer.masksToBounds = true
        view.addSubview(menuView)
        menuView.backgroundColor = .systemGray6
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
    
    // MARK: - Cell Register
    func registerCell() {
        tableView.register(UINib(nibName: "CoinTableViewCell", bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    @objc func sortBy24hVol() {
        guard let viewModel = self.viewModel else {return}
        viewModel.cryptoList?.coins!.sort{ (coinOne, coinTwo) -> Bool in
            return coinOne.the24HVolume ?? "" < coinTwo.the24HVolume ?? ""
        }
        DispatchQueue.main.async { [self] in
            self.tableView.reloadData()
            menuView.isHidden = true
            
        }
        sortButton.setTitle("24 Vol", for: .normal)
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
        sortButton.setTitle("Price", for: .normal)
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
        sortButton.setTitle("Change", for: .normal)
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
        sortButton.setTitle("Market Cap", for: .normal)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! CoinTableViewCell
        let model = viewModel?.cryptoList?.coins![indexPath.section]
        cell.configCell(model: model!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailVc = storyboard.instantiateViewController(withIdentifier: "DetailID") as! DetailViewController
        let selected = self.viewModel?.cryptoList?.coins![indexPath.section]
        detailVc.selectedCrypto = selected
        self.navigationController?.pushViewController(detailVc, animated: true)
    }
   
}



