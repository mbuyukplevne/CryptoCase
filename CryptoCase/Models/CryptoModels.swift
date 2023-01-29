//
//  CryptoModels.swift
//  CryptoCase
//
//  Created by Mehdican Büyükplevne on 28.01.2023.
//

import Foundation

// MARK: - Cryptos
public struct Cryptos: Codable {
    let status: String?
    let data: DataClass?
}

// MARK: - Dataclass
public struct DataClass: Codable {
    public let stats: Stats?
    public let coins: [Coins]?
    
}

// MARK: - Stats
public struct Stats: Codable {
    let total,totalCoins,totalMarkets,totalExchanges: Int?
    let totalMarketCap,total24HVolume: String?
    
    enum CodingKeys: String, CodingKey {
        case total, totalCoins, totalMarkets, totalExchanges, totalMarketCap
        case total24HVolume = "total24hVolume"
    }
}

// MARK: - Coins
public struct Coins: Codable {
    let uuid,symbol,name: String?
    let color: String?
    let iconURL: String?
    let marketCap, price: String?
    let listedAt, tier: Int?
    let change: String?
    let rank: Int?
    let sparkline: [String]?
    let lowVolume: Bool?
    let coinRankingURL: String?
    let the24HVolume: String?
    let btcPrice: String?
    
    enum CodingKeys: String, CodingKey {
        case uuid, symbol, name, color
        case iconURL = "iconUrl"
        case marketCap, price, listedAt, tier, change, rank, sparkline, lowVolume
        case coinRankingURL = "coinrankingUrl"
        case the24HVolume = "the24hVolume"
        case btcPrice
    }
}


