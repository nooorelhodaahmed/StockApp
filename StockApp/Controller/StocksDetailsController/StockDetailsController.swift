//
//  StockDetailsController.swift
//  StockApp
//
//  Created by norelhoda on 21.01.2022.
//

import UIKit

import Charts

class StockDetailsController: UIViewController, ChartViewDelegate {
    
    //MARK:- Proporties
    
    var id : Int?
    var stockDetails: StockDetailModel?
   
    lazy var viewModel : StockDetailsViewModel =  {
        return StockDetailsViewModel()
    }()
    
    var data = [Double]()
    var xLabels =  [String]()
    
    @IBOutlet var chartView: LineChartView!
    @IBOutlet var sliderX: UISlider!
    @IBOutlet var sliderY: UISlider!
    @IBOutlet var sliderTextX: UITextField!
    @IBOutlet var sliderTextY: UITextField!
    @IBOutlet weak var symbol: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var difference: UILabel!
    @IBOutlet weak var TransactionVolume: UILabel!
    @IBOutlet weak var buying: UILabel!
    @IBOutlet weak var sales: UILabel!
    @IBOutlet weak var dailLow: UILabel!
    @IBOutlet weak var dailyHigh: UILabel!
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var celing: UILabel!
    @IBOutlet weak var base: UILabel!
    @IBOutlet weak var arrowImage: UIImageView!
    
    //MARK:- LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initVM()
        self.title = "Filled Line Chart"
        chartView.delegate = self
        setUpchart()
    }
    
    func initVM() {
        
        viewModel.fetchSelectedStockDetails(id: id!)
        viewModel.reloadData = { [weak self] in
            self?.initView()
        }
        viewModel.setSymbolValue = { [weak self] in
            guard let symbolValue = self?.viewModel.symbolValue else{return}
            self?.symbol.text = (self?.symbol.text!)! + " " + symbolValue
        }
        viewModel.reloadGraghData = { [weak self] in
            
            guard let days = self?.viewModel.stockDays else {return}
            self?.xLabels = days
            guard let data = self?.viewModel.stockValues else {return}
            self?.data = data
            //self?.setDataCount(xLabels, range: UInt32(data))
        }
    }
    
    func initView(){
        
        guard let stockDetails = viewModel.stockDetails else {return}
        self.price.text = self.price.text! + " " + String(Double((stockDetails.price?.roundToDecimal(2))!))
        self.difference.text = self.difference.text! + " " + String(Double((stockDetails.difference?.roundToDecimal(2))!) * 100) + "%"
        self.TransactionVolume.text =  self.TransactionVolume.text! + " " + String(Double((stockDetails.volume?.roundToDecimal(2))!))
        self.buying.text = self.buying.text! + " " + String(Double((stockDetails.bid?.roundToDecimal(2))!))
        self.dailLow.text = self.dailLow.text! + " " + String(Double((stockDetails.lowest?.roundToDecimal(2))!))
        self.dailyHigh.text = self.dailyHigh.text! + " " + String(Double((stockDetails.highest?.roundToDecimal(2))!))
        self.celing.text = self.celing.text! + " " + String(Double((stockDetails.maximum?.roundToDecimal(2))!))
        self.base.text = self.base.text! + " " + String(Double((stockDetails.minimum?.roundToDecimal(2))!))
        self.sales.text = self.sales.text! + " " + String(Double((stockDetails.offer?.roundToDecimal(2))!))
        self.number.text = self.number.text! + " " + String(Double((stockDetails.channge)!))
        if stockDetails.isUp! {
            self.arrowImage.image = UIImage(named: "arrow-up-1")
        }
        else {
            self.arrowImage.image = UIImage(named: "arrow-down")
        }
    }
        
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

//MARK:- Chart

extension StockDetailsController {
    
    func setUpchart() {
        
        chartView.backgroundColor = .white
        chartView.gridBackgroundColor = UIColor(red: 51/255, green: 181/255, blue: 229/255, alpha: 150/255)
        chartView.drawGridBackgroundEnabled = true
        chartView.drawBordersEnabled = true
        chartView.chartDescription?.enabled = false
        chartView.pinchZoomEnabled = false
        chartView.dragEnabled = true
        chartView.setScaleEnabled(true)
        chartView.legend.enabled = false
        chartView.xAxis.enabled = false
        
        let leftAxis = chartView.leftAxis
        leftAxis.axisMaximum = 900
        leftAxis.axisMinimum = -250
        leftAxis.drawAxisLineEnabled = false
        
        chartView.rightAxis.enabled = false
        
        sliderX.value = 100
        sliderY.value = 60
        slidersValueChanged(nil)
    }
    
    
    func updateChartData() {
     /*  if self.shouldHideData {
           chartView.data = nil
           return
       }*/
       
       self.setDataCount(Int(sliderX.value), range: UInt32(sliderY.value))
   }
   
   func setDataCount(_ count: Int, range: UInt32) {
       let yVals1 = (0..<count).map { (i) -> ChartDataEntry in
           let val = Double(arc4random_uniform(range) + 50)
           return ChartDataEntry(x: Double(i), y: val)
       }
       let yVals2 = (0..<count).map { (i) -> ChartDataEntry in
           let val = Double(arc4random_uniform(range) + 450)
           return ChartDataEntry(x: Double(i), y: val)
       }
       
       let set1 = LineChartDataSet(entries: yVals1, label: "DataSet 1")
       set1.axisDependency = .left
       set1.setColor(UIColor(red: 255/255, green: 241/255, blue: 46/255, alpha: 1))
       set1.drawCirclesEnabled = false
       set1.lineWidth = 2
       set1.circleRadius = 3
       set1.fillAlpha = 1
       set1.drawFilledEnabled = true
       set1.fillColor = .white
       set1.highlightColor = UIColor(red: 244/255, green: 117/255, blue: 117/255, alpha: 1)
       set1.drawCircleHoleEnabled = false
       set1.fillFormatter = DefaultFillFormatter { _,_  -> CGFloat in
           return CGFloat(self.chartView.leftAxis.axisMinimum)
       }
       
       let set2 = LineChartDataSet(entries: yVals2, label: "DataSet 2")
       set2.axisDependency = .left
       set2.setColor(UIColor(red: 255/255, green: 241/255, blue: 46/255, alpha: 1))
       set2.drawCirclesEnabled = false
       set2.lineWidth = 2
       set2.circleRadius = 3
       set2.fillAlpha = 1
       set2.drawFilledEnabled = true
       set2.fillColor = .white
       set2.highlightColor = UIColor(red: 244/255, green: 117/255, blue: 117/255, alpha: 1)
       set2.drawCircleHoleEnabled = false
       set2.fillFormatter = DefaultFillFormatter { _,_  -> CGFloat in
           return CGFloat(self.chartView.leftAxis.axisMaximum)
       }

       let data =  LineChartData()
       data.addDataSet(set1)
       data.addDataSet(set2)
       data.setDrawValues(false)
       
       chartView.data = data
   }
   
   @IBAction func slidersValueChanged(_ sender: Any?) {
       sliderTextX.text = "\(Int(sliderX.value))"
       sliderTextY.text = "\(Int(sliderY.value))"
       
       self.updateChartData()
   }
}


