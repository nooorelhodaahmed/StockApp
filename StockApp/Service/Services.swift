//
//  Services.swift
//  StockApp
//
//  Created by norelhoda on 22.01.2022.
//


import Alamofire
import AlamofireMapper
import ProgressHUD
import UIKit


class Services {
    
    //MARK:- Authentication
    
    
    static let shared  = Services()
    
    var encryptionData : EncryptionData?
    
    public func getHandSkeData(successCompletion: @escaping ((_ json : HandsShakeModel) -> Void)){
        
            let headers = ["Content-Type":"application/json"]
            
                let id = UIDevice.current.identifierForVendor!.uuidString
                
                let  Parmters :[String:Any]  =
                    
                    ["deviceId": id,
                     "systemVersion": "14.5",
                     "platformName": "iOS",
                     "deviceModel": "iPhone 11",
                     "manifacturer": "Apple"]
        
         ProgressHUD.show()
        
        Alamofire.request(EndPiont.handShakeUrl , method: .post,parameters: Parmters, encoding: JSONEncoding.default, headers: headers).responseObject { (response : DataResponse<HandsShakeModel>) in
             
          switch response.result {
                 case .success( _):
                     let json = response.data
                         let decoder = JSONDecoder()
                        
                         do {
                            
                             let usersList: HandsShakeModel = try decoder.decode(HandsShakeModel.self, from: json!)
                           
                                 successCompletion(usersList)
                            
                                    if (usersList.status?.isSuccess)! {
                                        self.encryptionData = EncryptionData(key: usersList.aesKey!, iv: usersList.aesIV!, authorization: usersList.authorization!)
                                       }
                          
                                      ProgressHUD.dismiss()
                                      break
                                }
                          catch {
                                     ProgressHUD.dismiss()
                                     break
                         }
                 case .failure(let error):
                     print(error.localizedDescription)
                     ProgressHUD.dismiss()
                     break
                 }
            }
     }


    public func getStockList(parms:String,successCompletion: @escaping ((_ json : StockListModel) -> Void)){
       
        guard let authorization = encryptionData?.authorization else {return}
        
        let headers = ["Accept":"application/json","X-VP-Authorization": authorization]
        
        ProgressHUD.show()
        
        Alamofire.request(EndPiont.stockListUrl , method: .post, parameters: ["period":parms],encoding: JSONEncoding.default, headers: headers).responseObject { (response : DataResponse<StockListModel>) in
            
                switch response.result {
                case .success( _):
                    let json = response.data
                        let decoder = JSONDecoder()
                       
                        do {
                           
                            let usersList: StockListModel = try decoder.decode(StockListModel.self, from: json!)
                            successCompletion(usersList)
                            ProgressHUD.dismiss()
                            break
                         }
                             catch {
                                ProgressHUD.dismiss()
                                break
                           
                        }
                case .failure(let error):
                    print(error.localizedDescription)
                    ProgressHUD.dismiss()
                    break
                }
           }
    }
    
    
    public func getStockDetails(Parmters :String,successCompletion: @escaping ((_ json : StockDetailModel) -> Void)){
       
        guard let authorization = encryptionData?.authorization else {return}
        
        let headers = ["Accept":"application/json","X-VP-Authorization": authorization]
       
        Alamofire.request("https://mobilechallenge.veripark.com/api/stocks/detail",method: .post, parameters: ["id":Parmters],encoding: JSONEncoding.default, headers: headers).responseObject { (response : DataResponse<StockDetailModel>) in
            
                switch response.result {
                case .success( _):
                    let json = response.data
                        let decoder = JSONDecoder()
                       
                        do {
                           
                            let usersList: StockDetailModel = try decoder.decode(StockDetailModel.self, from: json!)
                            print(usersList)
                          
                            successCompletion(usersList)
                            ProgressHUD.dismiss()
                            break
                           
                        }
                             catch {
                                ProgressHUD.dismiss()
                                break
                           
                        }
                case .failure(let error):
                  
                    print(error.localizedDescription)
                    ProgressHUD.dismiss()
                    break
                }
         }
     }
  }

