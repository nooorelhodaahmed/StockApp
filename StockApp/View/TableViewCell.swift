//
//  TableViewCell.swift
//  StockApp
//
//  Created by norelhoda on 21.01.2022.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var symbol: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var difference: UILabel!
    @IBOutlet weak var transcitionVolum: UILabel!
    @IBOutlet weak var buying: UILabel!
    @IBOutlet weak var sales: UILabel!
    @IBOutlet weak var arrowDirection: UIImageView!
    
    func setup(with stock: StocksModified){
        symbol.text = stock.symbol
        price.text = String((stock.price!))
        difference.text = String((stock.difference!))
        transcitionVolum.text = String((stock.volume!))
        buying.text = String((stock.bid!))
        sales.text = String((stock.offer!))
        
        if stock.isUp! {
            arrowDirection.image = UIImage(named: "arrow-up-1")
            arrowDirection.contentMode = .scaleAspectFit
            arrowDirection.clipsToBounds = true
        }
        else {
            arrowDirection.image = UIImage(named: "arrow-down")
            arrowDirection.contentMode = .scaleAspectFit
            arrowDirection.clipsToBounds = true
        }
    }
}
