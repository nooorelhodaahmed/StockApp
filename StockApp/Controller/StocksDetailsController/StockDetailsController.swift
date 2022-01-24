//
//  StockDetailsController.swift
//  StockApp
//
//  Created by norelhoda on 21.01.2022.
//

import UIKit
import Charts

class StockDetailsController: UIViewController{
    
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
    }
    
    //MARK:- binding of viewModel
    
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
            self?.setUpchart(xdata:data,ydata:self!.xLabels)
        }
    }
    
    //MARK:- intiate data for view
    
    func initView(){
        
        guard let stockDetails = viewModel.stockDetails else {return}
        self.price.text = self.price.text! + " " + String(Double((stockDetails.price?.roundToDecimal(2))!))
        self.difference.text = self.difference.text! + " " + String(Double((stockDetails.difference?.roundToDecimal(2))!)) + "%"
        self.TransactionVolume.text =  self.TransactionVolume.text! + " " + String(Double((stockDetails.volume?.roundToDecimal(2))!)).prefix(3)
        self.buying.text = self.buying.text! + " " + String(Double((stockDetails.bid?.roundToDecimal(2))!))
        self.dailLow.text = self.dailLow.text! + " " + String(Double((stockDetails.lowest?.roundToDecimal(2))!))
        self.dailyHigh.text = self.dailyHigh.text! + String(Double((stockDetails.highest?.roundToDecimal(2))!))
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

extension StockDetailsController:ChartViewDelegate{
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        chartView.drawMarkers = true
        chartView.setNeedsDisplay()
    }
    
    func setUpchart(xdata:[Double],ydata:[String]) {
        
        chartView.delegate = self
        chartView.chartDescription?.enabled = false
        chartView.dragEnabled = true
        chartView.setScaleEnabled(true)
        chartView.pinchZoomEnabled = true
        
        // x-axis limit line
        let llXAxis = ChartLimitLine(limit: 10, label: "Index 1")
        llXAxis.lineWidth = 4
        llXAxis.lineDashLengths = [10, 10, 0]
        llXAxis.labelPosition = .bottomRight
        llXAxis.valueFont = .systemFont(ofSize: 10)

        chartView.xAxis.gridLineDashLengths = [10, 10]
        chartView.xAxis.gridLineDashPhase = 0

        let ll1 = ChartLimitLine(limit: xdata.max()!, label: "Upper Limit")
        ll1.lineWidth = 4
        ll1.lineDashLengths = [5, 5]
        ll1.labelPosition = .bottomRight
        ll1.valueFont = .systemFont(ofSize: 10)

        let leftAxis = chartView.leftAxis
        leftAxis.removeAllLimitLines()
        leftAxis.addLimitLine(ll1)
        leftAxis.axisMaximum = xdata.max()!
        leftAxis.axisMinimum = xdata.min()!
        leftAxis.gridLineDashLengths = [5, 5]
        leftAxis.drawLimitLinesBehindDataEnabled = true
        
        chartView.rightAxis.enabled = false

        let marker = MarkerView(frame: CGRect(x: 8, y: 8, width: 80, height: 40))
        chartView.marker = marker
        chartView.drawMarkers = true
        chartView.legend.form = .line

        sliderX.value = 15
        sliderX.maximumValue = 30
        sliderY.value = 30
        slidersValueChanged(nil)

        chartView.animate(xAxisDuration: 2.5)
    }
    
     func updateChartData() {
        self.setDataCount(Int(sliderX.value), range: UInt32(sliderY.value))
    }

    func setDataCount(_ count: Int, range: UInt32) {
        
       let values = (0..<count).map { (i) -> ChartDataEntry in
       let val = self.data[i]
            return ChartDataEntry(x: Double(i), y: val)
        }
    
        let set1 = LineChartDataSet(entries: values, label: "Days")
        set1.drawIconsEnabled = true
        setup(set1)

        let gradientColors = [ChartColorTemplates.colorFromString("#00ff0000").cgColor,ChartColorTemplates.colorFromString("#ffff0000").cgColor]
        let gradient = CGGradient(colorsSpace: nil, colors: gradientColors as CFArray, locations: nil)!

        set1.fillAlpha = 0.8
        set1.fill = Fill(linearGradient: gradient, angle: 90)
        
        let data = LineChartData(dataSet: set1)
        chartView.data = data
        
        guard let dataa = chartView.data else { return }
        for case let set as LineChartDataSet in  dataa.dataSets {
            set.drawFilledEnabled = !set.drawFilledEnabled
        }
        chartView.setNeedsDisplay()
    }

    private func setup(_ dataSet: LineChartDataSet) {
        
            dataSet.lineDashLengths = [5, 2.5]
            dataSet.highlightLineDashLengths = [5, 2.5]
            dataSet.setColors(.black, .red, .white)
            dataSet.setCircleColor(.black)
            dataSet.lineWidth = 1
            dataSet.circleRadius = 4
            dataSet.drawCircleHoleEnabled = false
            dataSet.valueFont = .systemFont(ofSize: 9)
            dataSet.formLineDashLengths = [5, 2.5]
            dataSet.formLineWidth = 1
            dataSet.formSize = 15
    }
   
    @IBAction func slidersValueChanged(_ sender: Any?) {
        sliderTextX.text = "\(Int(sliderX.value))"
        sliderTextY.text = "\(Int(sliderY.value))"

        self.updateChartData()
    }
}



