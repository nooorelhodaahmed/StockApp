//
//  StockDetailsViewModel.swift
//  StockApp
//
//  Created by norelhoda on 23.01.2022.
//

import Foundation


class StockDetailsViewModel {
    
    var stockDetails : StockDetailModel?
    var symbolValue: String?
    var stockDays = [String]()
    var stockValues = [Double]()
    
    var reloadData :(()->())?
    var reloadGraghData :(()->())?
    var setSymbolValue : (()->())?
    
    func fetchSelectedStockDetails(id:Int)  {
       
        let encryptedId = EncyptionAndDecryption.shared.Encryption(data: String(id))
        
        if encryptedId != "" {
            
            Services.shared.getStockDetails(Parmters: encryptedId) { success in
                if (success.status?.isSuccess)! {
                    self.stockDetails = success
                    self.fetchSymbolValue(symbol:success.symbol!)
                    self.setGraphData(data: success.graphicData!)
                    self.reloadData?()
                }
            }
        }
    }
    
    func fetchSymbolValue(symbol:String){
        
            let symbolValue = EncyptionAndDecryption.shared.Decryption(data: symbol)
            if symbolValue != "" {
                self.symbolValue = symbolValue
                self.setSymbolValue?()
        }
    }
    
    func setGraphData(data:[GraphicData]) {
        
        for graph in data {
            
            stockDays.append(String(graph.day!))
            stockValues.append((graph.value?.roundToDecimal(2))!)
        }
        self.reloadGraghData?()
    }
}
