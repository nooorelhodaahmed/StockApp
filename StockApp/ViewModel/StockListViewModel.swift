//
//  StockListViewModel.swift
//  StockApp
//
//  Created by norelhoda on 23.01.2022.
//

import Foundation
import UIKit


class StockListViewModel {
    
    var stockList : [Stocks]? {
        didSet{
            self.reloadTableView?()
        }
    }
    
    var filteredData :[StocksModified] = []
   
    var searchIsActive: Bool = false {
        didSet{
            self.reloadTableView?()
        }
    }
    
    var alertMessage : String? {
        didSet {
            self.showAlert?()
        }
    }
    
    var period : String? {
        didSet{
            self.fetchData(period: period!)
        }
    }
    
    var symbolValues = [String]()
    var stockListwithSymbolValue = [StocksModified]()
    var reloadTableView:(()->())?
    var showAlert:(()->())?
   
    
    //MARK:- fecth stockList data
    
    func fetchData (period:String) {
       
        let period = EncyptionAndDecryption.shared.Encryption(data: period)
        
        if period != "" {
           
            Services.shared.getStockList(parms: period) { success in
                if let stockListValue = success.stocks{
                    self.deleteEmptyStocks (data:stockListValue, completion: {
                        self.fetchSymbolValue(data: self.stockList!)
                    })
                }
            }
        }
        else {
            self.alertMessage = "something wrong please try again later"
        }
    }
    
    //MARK:- check and remove empty stocks from the array
    
    func deleteEmptyStocks (data:[Stocks],completion: () -> ()) {
       
        let listOfStocks = data.filter{ $0.price != 0.0}
        self.stockList = listOfStocks
        
        completion()
    }
    
    //MARK:- fetch value of encrypted symbol
    
    func fetchSymbolValue(data:[Stocks]){
       
        var array = [String]()
        
        for stock in data {
            let symbolValue = EncyptionAndDecryption.shared.Decryption(data: stock.symbol!)
            if symbolValue != "" {
                array.append(symbolValue)
            }
        }
        self.symbolValues = array
        self.createModifiesStockList(data:data)
    }
    
    //MARK:- create stocklist with symbolvalue
    
    func createModifiesStockList(data:[Stocks]) {
        
       var array = [StocksModified]()
       var i = 0

       for stock in data {
        let volum = String(stock.volume!).prefix(3)
        let modifiedStock = StocksModified(id: stock.id, isDown: stock.isDown, isUp: stock.isUp, bid: stock.bid, difference: stock.difference, offer: stock.offer, price: stock.price, volume: Double(volum), symbol: symbolValues[i])
        array.append(modifiedStock)
        i = i+1
        }
        
        self.stockListwithSymbolValue = array
    }
    
    //MARK:- setUp SelectedStock viewController
    
    func setSelectedController(id: Int) -> UIViewController{
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = (storyboard.instantiateViewController(withIdentifier: "StockDetailsController") as! StockDetailsController)
        viewController.modalPresentationStyle = .fullScreen
        viewController.id = id
        return viewController
    }
}


