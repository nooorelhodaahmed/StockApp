//
//  HomeViewModel.swift
//  StockApp
//
//  Created by norelhoda on 23.01.2022.
//

import Foundation


class HomeViewModel {
    
    var alertMessage : String? {
        didSet {
            self.showAlert?()
        }
    }
    
    var period : String? {
        didSet{
            self.getALLStockData()
        }
    }
    
    var stockList : [Stocks]? {
        didSet{
            self.openStockView?()
        }
    }
    
    var showAlert:(()->())?
    var openStockView:(()->())?
    
    func getHandShakeData() {
        
        Services.shared.getHandSkeData { success in
          
            if !(success.status?.isSuccess)! {
                self.alertMessage = success.status?.error?.message
            }
        }
    }
    
    func getALLStockData() {
       
    }
    
}
