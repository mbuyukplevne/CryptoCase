//
//  CryptoListViewModel.swift
//  CryptoCase
//
//  Created by Mehdican Büyükplevne on 28.01.2023.
//

import Foundation
import UIKit

final class CryptoListViewModel {
    var cryptoList: DataClass?
    private let APIService: APICallService
    
    init(APIService: APICallService) {
        self.APIService = APIService
    }
    
    func getSparklineMinMax(index: Int) -> (min: Double, max: Double) {
        let sparkline = cryptoList?.coins![index].sparkline
        let min = Double((sparkline?.min())!)
        let max = Double((sparkline?.max())!)
        return(min!,max!)
    }
    
    func getCrypto(completionHandler: @escaping () -> Void) {
        APIService.getCrypto { result in
            switch result {
            case .success(let response):
                if let cryptos = response.data {
                    self.cryptoList = cryptos
                }
                
                completionHandler()
            case .failure(let error):
                print(error)
            }
        }
    }
}


