//
//  APIConstants.swift
//  CryptoCase
//
//  Created by Mehdican Büyükplevne on 29.01.2023.
//

import Foundation

enum APICall: String {
    case getData
    
    private var urlString: String {
        switch self {
        case .getData:
            return "https://psp-merchantpanel-service-sandbox.ozanodeme.com.tr/api/v1/dummy/coins"
        }
    }
    
    var url: URL {
        switch self {
        case .getData:
            return URL(string: urlString)!
        }
    }
}
