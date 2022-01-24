//
//  SideMenuControllerViewController.swift
//  StockApp
//
//  Created by norelhoda on 20.01.2022.
//

import UIKit

protocol sideMenuControllerDelegate {
    func buttonIsSelected(id:Int)
}

class SideMenuControllerViewController: UIViewController {
    
    //MARK:- Proporties
    
    @IBOutlet weak var logoImg: UIImageView!
    @IBOutlet weak var logoLabel: UILabel!
    @IBOutlet weak var viewTitle: UILabel!
    @IBOutlet weak var hisseButton: UIButton!
    @IBOutlet weak var YükselenlerButton: UIButton!
    @IBOutlet weak var DüşenlerButton: UIButton!
    @IBOutlet weak var HacmeGöre30: UIButton!
    @IBOutlet weak var HacmeGöre50: UIButton!
    @IBOutlet weak var HacmeGöre100: UIButton!
    @IBOutlet weak var headerView: UIView!
    
    var delegate:sideMenuControllerDelegate?
   
    //MARK:-LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       configureGradiantColor()
    }
    
    //MARK:- HelperFunction
    
    func configureGradiantColor(){
        
        let gray1 = hexStringToUIColor(hex: "#BFBFBF")
        let gray2 = hexStringToUIColor(hex: "#FAFAFA")
        
        let gradiantLayer = CAGradientLayer()
        gradiantLayer.frame = headerView.bounds
        gradiantLayer.colors = [gray1.cgColor,gray2.cgColor]
        gradiantLayer.startPoint = CGPoint(x: 0, y: 0)
        gradiantLayer.endPoint = CGPoint(x: 1, y: 1)
        headerView.layer.addSublayer(gradiantLayer)
        headerView.bringSubviewToFront(logoImg)
        headerView.bringSubviewToFront(logoLabel)
        headerView.bringSubviewToFront(viewTitle)
    }
    
    func changeSelectedButtonColor(selectedButton:UIButton){
        let arrayOfButtons = [hisseButton,YükselenlerButton,DüşenlerButton,
                              HacmeGöre30,HacmeGöre50,HacmeGöre100]
        
        for button in arrayOfButtons {
            if button == selectedButton{
                button!.backgroundColor = UIColor.systemGray5
                button!.setTitleColor(.mainRed, for: .normal)
            }
            else {
                button!.backgroundColor = UIColor.clear
                button!.setTitleColor(.black, for: .normal)
            }
        }
    }
    
    //MARK:- Selector Function
    
    @IBAction func HisseVeEndekslerButton(_ sender: UIButton) {
        changeSelectedButtonColor(selectedButton:sender)
        delegate?.buttonIsSelected(id: 1)
    }
    
    @IBAction func YükselenlerButtonSelected(_ sender: UIButton) {
        changeSelectedButtonColor(selectedButton:sender)
        delegate?.buttonIsSelected(id: 2)
    }
    
    @IBAction func DüşenlerButtonSelected(_ sender: UIButton) {
        changeSelectedButtonColor(selectedButton:sender)
        delegate?.buttonIsSelected(id: 3)
    }
    
    @IBAction func HacmeGöre30Selected(_ sender: UIButton) {
        changeSelectedButtonColor(selectedButton:sender)
        delegate?.buttonIsSelected(id: 4)
    }
    
    @IBAction func HacmeGöre50Selected(_ sender: UIButton) {
        changeSelectedButtonColor(selectedButton:sender)
        delegate?.buttonIsSelected(id: 5)
    }
    
    @IBAction func HacmeGöre100Selected(_ sender: UIButton) {
        changeSelectedButtonColor(selectedButton:sender)
        delegate?.buttonIsSelected(id: 6)
    }
}
