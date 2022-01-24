//
//  ViewController.swift
//  StockApp
//
//  Created by norelhoda on 20.01.2022.
//

import UIKit
import CryptoSwift
import ProgressHUD

class MainStocksController: UIViewController{
   
    //MARK:- Proporties
    
    lazy var viewModel : StockListViewModel =  {
    
        return StockListViewModel()
    }()
    var sideMenuController = SideMenuControllerViewController()
    private var isHamburgerMenuShown:Bool = false
    var beginPoint:CGFloat = 0.0
    var difference:CGFloat = 0.0
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var sideMenuView: UIView!
    @IBOutlet weak var leadingConstarinForMenu: NSLayoutConstraint!
    @IBOutlet weak var sideMenuBackgroundView: UIView!
    
    //MARK:-LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        initvm()
    }
    
    func initView(){
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        setSearchBar()
        sideMenuBackgroundView.isHidden = true
    }
    
    //MARK:- binding of viewModel
    
    func initvm() {
        
        viewModel.fetchData(period: "all")
        viewModel.reloadTableView = { [weak self] in
            self?.tableView.reloadData()
        }
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
}

//MARK:-UITbaleViewDelegate & UITableViewDatasource

extension MainStocksController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if  viewModel.searchIsActive {
            return viewModel.filteredData.count
          } else {
            return (viewModel.stockList?.count ?? 0)
          }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = (tableView.dequeueReusableCell(withIdentifier: "TableViewCell"))! as! TableViewCell
        
        
        if (viewModel.searchIsActive) {
            if (indexPath.row)%2 != 0 {
                cell.backgroundColor = UIColor.systemGray6
            }
            else {
                cell.backgroundColor = UIColor.white
            }
            
            cell.setup(with: viewModel.filteredData[indexPath.row])
            cell.selectionStyle = .none
            return cell
             
          }
          else {
            if (indexPath.row)%2 != 0 {
                cell.backgroundColor = UIColor.systemGray6
            }
            else {
                cell.backgroundColor = UIColor.white
            }
            
            cell.setup(with: (viewModel.stockListwithSymbolValue[indexPath.row]))
            cell.selectionStyle = .none
            return cell
          }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if viewModel.searchIsActive {
            guard let id = viewModel.filteredData[indexPath.row].id else {return}
            self.present(self.viewModel.setSelectedController(id:id), animated: true, completion: nil)
        }
        else {
            guard let id = viewModel.stockList?[indexPath.row].id else {return}
            
            self.present(self.viewModel.setSelectedController(id:id), animated: true, completion: nil)
        }
    }
}

//MARK:- Serach

extension MainStocksController: UISearchBarDelegate {
    
    
    func setSearchBar(){
        
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor(hex: 0xFFFFFF)]
        UINavigationBar.appearance().tintColor = UIColor.white
        searchBar.setImage(UIImage(), for: .search, state: .normal)
        searchBar.placeholder = "Ara"
        searchBar.delegate = self
        searchBar.backgroundColor = UIColor.white
        var searchText : UITextField?
        if #available(iOS 13.0, *) {
           searchText  = searchBar.searchTextField
        }
        else {
            searchText = searchBar.value(forKey: "_searchField") as? UITextField
        }
        searchText?.backgroundColor = .white
        searchText?.layer.borderWidth = 1
        searchText?.layer.borderColor = UIColor.systemGray5.cgColor
        searchText?.layer.cornerRadius = 7
        searchBar.backgroundImage = UIImage()
        searchText?.setUnderLine()
        
        
        if let searchTextField = self.searchBar.value(forKey: "searchField") as? UITextField , let clearButton = searchTextField.value(forKey: "_clearButton")as? UIButton {

             clearButton.addTarget(self, action: #selector(self.searchFunction), for: .touchUpInside)
        }
    }
    
    @objc func searchFunction (){
        
        self.viewModel.searchIsActive = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        viewModel.searchIsActive = true
        if searchText != "" {
            
            let array = viewModel.stockListwithSymbolValue.filter { result in
                return (result.symbol?.lowercased().contains(searchText.lowercased()))!
                      
            }
            viewModel.filteredData = array
            self.tableView.reloadData()
        }
        
       else {
        viewModel.searchIsActive = false
            tableView.reloadData()
        }
    }
}


  
//MARK:- SideMenu

extension MainStocksController : sideMenuControllerDelegate {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sideMenuSegue" {
            if let controller = segue.destination as? SideMenuControllerViewController{
                self.sideMenuController = controller
                self.sideMenuController.delegate = self
            }
        }
    }
    
    @IBAction func sideMenuClick(_ sender: Any) {
       
        UIView.animate(withDuration: 0.1) {
            self.leadingConstarinForMenu.constant = 10
            self.view.layoutIfNeeded()
        } completion: { (status) in
            self.sideMenuBackgroundView.alpha = 0.75
            self.sideMenuBackgroundView.isHidden = false
            UIView.animate(withDuration: 0.1) {
                self.leadingConstarinForMenu.constant = 0
                self.view.layoutIfNeeded()
            } completion: { (status) in
                self.isHamburgerMenuShown = true
            }

        }
    }
    
    @IBAction func SideMenuBackGroundClicked(_ sender: Any) {
        self.hideSideMenuView()
    }
    
    func hideSideMenuView(){
        
        UIView.animate(withDuration: 0.1) {
            self.leadingConstarinForMenu.constant = 10
            self.view.layoutIfNeeded()
        } completion: { (status) in
            self.sideMenuBackgroundView.alpha = 0.0
            UIView.animate(withDuration: 0.1) {
                self.leadingConstarinForMenu.constant = -280
                self.view.layoutIfNeeded()
            } completion: { (status) in
                self.sideMenuBackgroundView.isHidden = true
                self.isHamburgerMenuShown = false
            }
        }
        
        self.leadingConstarinForMenu.constant = -280
        self.sideMenuBackgroundView.isHidden = true
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if (isHamburgerMenuShown)
        {
             if let touch = touches.first
            {
                let location = touch.location(in: sideMenuBackgroundView)
                beginPoint = location.x
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if (isHamburgerMenuShown)
        {
            if let touch = touches.first
            {
                let location = touch.location(in: sideMenuBackgroundView)
                
                let differenceFromBeginPoint = beginPoint - location.x
                
                if (differenceFromBeginPoint>0 && differenceFromBeginPoint<280)
                {
                    difference = differenceFromBeginPoint
                    self.leadingConstarinForMenu.constant = -differenceFromBeginPoint
                    self.sideMenuBackgroundView.alpha = 0.75-(0.75*differenceFromBeginPoint/280)
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if (isHamburgerMenuShown)
        {
            if (difference>140)
            {
                UIView.animate(withDuration: 0.1) {
                    self.leadingConstarinForMenu.constant = -290
                } completion: { (status) in
                    self.sideMenuBackgroundView.alpha = 0.0
                    self.isHamburgerMenuShown = false
                    self.sideMenuBackgroundView.isHidden = true
                }
            }
            
            else{
                UIView.animate(withDuration: 0.1) {
                    self.leadingConstarinForMenu.constant = -10
                } completion: { (status) in
                    self.sideMenuBackgroundView.alpha = 0.75
                    self.isHamburgerMenuShown = true
                    self.sideMenuBackgroundView.isHidden = false
                }
            }
        }
    }
    func buttonIsSelected(id: Int) {
        
        switch id {
        
        case 1:
            viewModel.fetchData(period: "all")
            self.hideSideMenuView()
        case 2:
            viewModel.fetchData(period: "increasing")
            self.hideSideMenuView()
        case 3:
            viewModel.fetchData(period: "decreasing")
            self.hideSideMenuView()
        case 4:
            viewModel.fetchData(period: "volume30")
            self.hideSideMenuView()
        case 5:
            viewModel.fetchData(period: "volume50")
            self.hideSideMenuView()
        case 6:
            viewModel.fetchData(period: "volume100")
            self.hideSideMenuView()
        default:
            viewModel.fetchData(period: "all")
            self.hideSideMenuView()
        }
    }
}

