//
//  Constants.swift
//  StockApp
//
//  Created by norelhoda on 22.01.2022.
//

import Foundation

struct EndPiont {
    
    static let handShakeUrl = "https://mobilechallenge.veripark.com/api/handshake/start"
    static let stockListUrl = "https://mobilechallenge.veripark.com/api/stocks/list"
    static let stockDetails = "https://mobilechallenge.veripark.com/api/stocks/detail"
}

struct EncryptionData {
    var key : String
    var iv : String
    var authorization : String
}


