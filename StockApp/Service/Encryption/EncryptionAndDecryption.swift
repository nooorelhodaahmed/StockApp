//
//  EncryptionAndDecryption.swift
//  StockApp
//
//  Created by norelhoda on 22.01.2022.
//

import UIKit
import CryptoSwift
import ProgressHUD

struct EncyptionAndDecryption {
    
    static let shared  = EncyptionAndDecryption()
    
    var key = [UInt8](base64: Services.shared.encryptionData?.key ?? "")
    var iv  = [UInt8](base64: Services.shared.encryptionData?.iv ?? "")
    
    
    func Encryption (data:String) -> String {
       
        ProgressHUD.show()
        var encryptedData :String?
        
        do {
    
        let aes = try AES(key: key, blockMode: CBC(iv: iv),padding: .pkcs7)
        let cipherText = try aes.encrypt(Array(data.utf8))
        encryptedData = (cipherText.toBase64())
        
    } catch {
        
        print(error)
    }
      
        return encryptedData ?? ""
    }
    
    
    func Decryption(data: String) -> String {
        
        
        var decryptesDataa :String?
        
        do {
            let aes = try AES(key: key, blockMode: CBC(iv: iv),padding: .pkcs7)
            let encryptedData = [UInt8](base64: data)
            let decryptedBytes = try aes.decrypt(encryptedData)
            let decryptedData = Data(decryptedBytes)
            decryptesDataa = String(decoding: decryptedData, as: UTF8.self)
            
        }
        catch{
            print(error)
        }
      return  decryptesDataa ?? ""
    }
}

