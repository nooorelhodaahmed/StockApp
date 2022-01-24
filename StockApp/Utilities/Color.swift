//
//  Color.swift
//  StockApp
//
//  Created by norelhoda on 20.01.2022.
//

import UIKit


extension UIColor {
    
    // Setup custom colours we can use throughout the app using hex values
    static let mainRed = UIColor(hex: 0xC7493E)
    
  
    // Create a UIColor from RGB
    convenience init(red: Int, green: Int, blue: Int, a: CGFloat = 1.0) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: a
        )
    }
    
    // Create a UIColor from a hex value (E.g 0x000000)
    convenience init(hex: Int, a: CGFloat = 1.0) {
        self.init(
            red: (hex >> 16) & 0xFF,
            green: (hex >> 8) & 0xFF,
            blue: hex & 0xFF,
            a: a
        )
    }
    
    class func color(_ hexString: String) -> UIColor? {
          if (hexString.count > 7 || hexString.count < 7) {
              return nil
          } else {
              let hexInt = Int(String(hexString[hexString.index(hexString.startIndex, offsetBy: 1)...]), radix: 16)
              if let hex = hexInt {
                  let components = (
                      R: CGFloat((hex >> 16) & 0xff) / 255,
                      G: CGFloat((hex >> 08) & 0xff) / 255,
                      B: CGFloat((hex >> 00) & 0xff) / 255
                  )
                  return UIColor(red: components.R, green: components.G, blue: components.B, alpha: 1)
              } else {
                  return nil
              }
          }
      }
}







func hexStringToUIColor (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }

    if ((cString.count) != 6) {
        return UIColor.gray
    }

    var rgbValue:UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)

    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}
