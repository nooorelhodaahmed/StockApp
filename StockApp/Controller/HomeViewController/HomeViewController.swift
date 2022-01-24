//
//  HomeViewController.swift
//  StockApp
//
//  Created by norelhoda on 22.01.2022.
//

import UIKit

class HomeViewController: UIViewController {

    lazy var viewModel : HomeViewModel =  {
        return HomeViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
       initvm()
    }
    //MARK:- binding of viewModel
    func initvm(){
        
        viewModel.getHandShakeData()
        viewModel.showAlert = { [weak self] in
            DispatchQueue.main.async {
                if let message = self?.viewModel.alertMessage {
                    self?.showAlert(message)
                }
            }
        }
    }
    
    func showAlert( _ message: String ) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func ShowStockButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = (storyboard.instantiateViewController(withIdentifier: "MainStocksController") as! MainStocksController)
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true, completion: nil)
    }
}
