//
//  StockChartViewController.swift
//  LGHTSG
//
//  Created by SunHo Lee on 2023/01/31.
//

import Foundation
import UIKit
import Charts
import SnapKit
class StockChartViewController : UIViewController {
        var stockPriceData = StockPriceModel()
        var EstatePriceData = EstatePriceModel()
        var nameText : String?

        var idx : Int?
        var pricePercentText : String?
        var changeDateText : String?
        var priceListDatas = [Int]()
        var timeListDatas = [String]()
        var temppriceListDatas = [Int]()
        var temptimeListDatas = [String]()
        lazy var lineChartView : LineChartView = {
            let chartView = LineChartView()
            return chartView
        }()
        private lazy var nameLabel : UILabel = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 17, weight: .semibold)
            label.text = nameText
            return label
        }()
        private lazy var priceLabel : UILabel = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 14, weight: .medium)
            label.textColor = UIColor.systemGray
           
            return label
        }()
        private lazy var pricePercent : UILabel = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 12, weight: .medium)
            label.text = pricePercentText
            if (label.text!.prefix(1) == "-"){
                label.textColor = UIColor.blue
            }else{
                label.textColor = UIColor.red
            }
            return label
        }()
        private lazy var changeDate : UILabel = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 12, weight : .medium)
            label.textColor = UIColor.systemGray
            label.text = changeDateText
            return label
        }()
        //MARK: - Label
        private lazy var dealLabel: UILabel = {
            let label = UILabel()
            label.text = "거래 이력"
            label.font = UIFont.systemFont(ofSize: 12, weight: .light)
            label.textColor = .white
            return label
        }()
        
        private lazy var revenueLabel: UILabel = {
            let label = UILabel()
            label.text = "구매 시점에 비해 얼마 올랐어요"
            label.textColor = .white
            label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
            return label
        }()
        

        private var lineImage = UnderlineView()
        
        
        //MARK: - SegmentControl
        private lazy var segmentCtrl: UISegmentedControl = {
            let items = ["1일","월", "1년", "5년"]
            let seg = UISegmentedControl(items: items)
            seg.addTarget(self, action: #selector(indexChanged(_:)), for: .valueChanged)
            seg.layer.cornerRadius = 0.7
            seg.backgroundColor = UIColor(named: "dropdown")
            seg.tintColor = .lightGray
            seg.setTitleTextAttributes(
              [
                  NSAttributedString.Key.foregroundColor: UIColor.white,
                .font: UIFont.systemFont(ofSize: 14, weight: .semibold)
              ],
              for: .selected
            )
            seg.setTitleTextAttributes(
              [
                  NSAttributedString.Key.foregroundColor: UIColor.systemGray,
                .font: UIFont.systemFont(ofSize: 14, weight: .semibold)
              ],
              for: .normal
            )
            seg.selectedSegmentIndex = 3
            return seg
        }()
        
        //MARK: - Button
        private lazy var sellButton: UIButton = {
            let btn = UIButton()
            btn.setTitle("판매", for: .normal)
            btn.setTitleColor(.blue, for: .normal)
            btn.backgroundColor = .white
            btn.layer.cornerRadius = 5
            btn.layer.borderWidth = 1
            return btn
            
        }()
        
        //MARK: - TableView
        private lazy var tableView: UITableView = {
            let table = UITableView()
            table.backgroundColor = .clear
            return table
            
        }()
        
        //MARK: - LifeCycle
        override func viewDidLoad() {
            super.viewDidLoad()
            
            configure()
            setLineChartView()
 
        }
        //MARK: - TableViewSetting
        func setupTableView(){
            tableView.delegate = self
            tableView.dataSource = self
            tableView.separatorStyle = .none
            tableView.register(EstateDetailCell.self, forCellReuseIdentifier: EstateDetailCell.identifier)
        }
        @objc func indexChanged(_ sender: UISegmentedControl){
            switch sender.selectedSegmentIndex{
            case 0:
                changeDate.text = "일주일 대비"
                let daypricedata : [Int] = priceListDatas.suffix(7)
                let daytimeListDatas : [String] = timeListDatas.suffix(7)
                self.setLineData(lineChartView: self.lineChartView, lineChartDataEntries: self.entryData( yvalues: daypricedata), xAxis: daytimeListDatas, recentPrice : Double(daypricedata.last!))
                temptimeListDatas = daytimeListDatas
                temppriceListDatas = daypricedata
                pricePercent.text =  "\(String(format: "%.2f", Double((temppriceListDatas.last! - temppriceListDatas[0])) / Double(temppriceListDatas[0]) * 100))%"
                if(pricePercent.text?.prefix(1) == "-"){
                    pricePercent.textColor = UIColor.blue
                }
                else{
                    pricePercent.textColor = UIColor.red
                }
                tableView.reloadData()
            case 1:
                changeDate.text = "한달 전 대비"
                let monthpricedata : [Int] = priceListDatas.suffix(31)
                let monthtimeListDatas : [String] = timeListDatas.suffix(31)
                self.setLineData(lineChartView: self.lineChartView, lineChartDataEntries: self.entryData( yvalues: monthpricedata), xAxis: monthtimeListDatas, recentPrice : Double(monthpricedata.last!))
                temppriceListDatas = monthpricedata
                temptimeListDatas = monthtimeListDatas
                pricePercent.text =  "\(String(format: "%.2f", Double((temppriceListDatas.last! - temppriceListDatas[0])) / Double(temppriceListDatas[0]) * 100))%"
                if(pricePercent.text?.prefix(1) == "-"){
                    pricePercent.textColor = UIColor.blue
                }
                else{
                    pricePercent.textColor = UIColor.red
                }
                tableView.reloadData()
            case 2:
                changeDate.text = "1년 전 대비"
                temppriceListDatas = []
                temptimeListDatas = []
                guard let recentTimestring = timeListDatas.last else{ return}
                // 만약 주식이 상장된지 1년이 안되었다면? 기준을 245개로 잡음
                if(timeListDatas.count < 243){
//                    temppriceListDatas = []
//                    temptimeListDatas = []
//                    for (index, element ) in timeListDatas.enumerated(){
//                        if index % 5 == 0 {
//                            temptimeListDatas.append(element)
//                        }
//                    }
//                    for (index, element ) in priceListDatas.enumerated(){
//                        if index % 5 == 0 {
//                            temppriceListDatas.append(element)
//                        }
//                    }
                    temppriceListDatas = priceListDatas
                    temptimeListDatas = timeListDatas
                    pricePercent.text =  "\(String(format: "%.2f", Double((temppriceListDatas.last! - temppriceListDatas[0])) / Double(temppriceListDatas[0]) * 100))%"
                    if(pricePercent.text?.prefix(1) == "-"){
                        pricePercent.textColor = UIColor.blue
                    }
                    else{
                        pricePercent.textColor = UIColor.red
                    }
                    self.setLineData(lineChartView: self.lineChartView, lineChartDataEntries: self.entryData( yvalues: priceListDatas), xAxis: timeListDatas, recentPrice : Double(priceListDatas.last!))
                    tableView.reloadData()
                }
                else{
                    let recenttimedata  = Array(recentTimestring)
                    let changeyear = Int(String(recenttimedata[3]))! - 1
                    let changeyearString = recentTimestring.prefix(3) + "\(changeyear)" + recentTimestring.dropFirst(4)
                    // 정확히 1년전데이터가 있는경우 ex) 2023-1-31 > 2022-1-31
                    if let firstindex = timeListDatas.firstIndex(of: String(changeyearString)) {
                        let temptimeList = Array(timeListDatas.dropFirst(firstindex))
                        for (index, element ) in temptimeList.enumerated(){
                            if index % 5 == 0 {
                                temptimeListDatas.append(element)
                            }
                        }
                        let temppriceList = Array(priceListDatas.dropFirst(firstindex))
                        for (index, element ) in temppriceList.enumerated(){
                            if index % 5 == 0 {
                                temppriceListDatas.append(element)
                            }
                        }
                        pricePercent.text =  "\(String(format: "%.2f", Double((temppriceListDatas.last! - temppriceListDatas[0])) / Double(temppriceListDatas[0]) * 100))%"
                        if(pricePercent.text?.prefix(1) == "-"){
                            pricePercent.textColor = UIColor.blue
                        }
                        else{
                            pricePercent.textColor = UIColor.red
                        }
                        self.setLineData(lineChartView: self.lineChartView, lineChartDataEntries: self.entryData( yvalues: temppriceListDatas), xAxis: temptimeListDatas, recentPrice : Double(temppriceListDatas.last!))
                        tableView.reloadData()
                    }
                    // 그런데 1년이상이지만 날짜상 그날이 휴장일일때를 대비해서 그냥 244개만 데이터 뽑기.
                    else{
                       let beforePriceData = priceListDatas.suffix(244)
                        let beforeTimeData = timeListDatas.suffix(244)
                        for (index, element ) in beforeTimeData.enumerated(){
                            if index % 5 == 0 {
                                temptimeListDatas.append(element)
                            }
                        }
                        for (index, element ) in beforePriceData.enumerated(){
                            if index % 5 == 0 {
                                temppriceListDatas.append(element)
                            }
                        }
                        if(!temptimeListDatas.contains( recentTimestring)){
                            temptimeListDatas.append(recentTimestring)
                            temppriceListDatas.append(priceListDatas.last!)
                        }
                        self.setLineData(lineChartView: self.lineChartView, lineChartDataEntries: self.entryData( yvalues: temppriceListDatas), xAxis: temptimeListDatas, recentPrice : Double(temppriceListDatas.last!))
                        pricePercent.text =  "\(String(format: "%.2f", Double((temppriceListDatas.last! - temppriceListDatas[0])) / Double(temppriceListDatas[0]) * 100))%"
                        if(pricePercent.text?.prefix(1) == "-"){
                            pricePercent.textColor = UIColor.blue
                        }
                        else{
                            pricePercent.textColor = UIColor.red
                        }
                        tableView.reloadData()
                    }}
   

            case 3:
                changeDate.text = "5년전 대비"
                temppriceListDatas = []
                temptimeListDatas = []
                for (index, element ) in timeListDatas.enumerated(){
                    if index % 5 == 0 {
                        temptimeListDatas.append(element)
                    }
                }
                for (index, element ) in priceListDatas.enumerated(){
                    if index % 5 == 0 {
                        temppriceListDatas.append(element)
                    }
                }
                pricePercent.text =  "\(String(format: "%.2f", Double((temppriceListDatas.last! - temppriceListDatas[0])) / Double(temppriceListDatas[0]) * 100))%"
                if(pricePercent.text?.prefix(1) == "-"){
                    pricePercent.textColor = UIColor.blue
                }
                else{
                    pricePercent.textColor = UIColor.red
                }
                self.setLineData(lineChartView: self.lineChartView, lineChartDataEntries: self.entryData( yvalues: temppriceListDatas), xAxis: temptimeListDatas, recentPrice : Double(temppriceListDatas.last!))
                tableView.reloadData()
            default:
                break
            }
        }
    }
    extension StockChartViewController : UITableViewDelegate, UITableViewDataSource {
        //cell 높이조절
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
                return 30
            }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return temptimeListDatas.count    }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: EstateDetailCell.identifier, for: indexPath) as? EstateDetailCell else { return UITableViewCell() }
            
            cell.date.text = temptimeListDatas[indexPath.row]
            cell.date.textColor = .white
            cell.price.text = "\(temppriceListDatas[indexPath.row])원"
            cell.price.textColor = .white
            cell.buysell.text = "hello"
            cell.buysell.textColor = .white
            return cell
        }
    }
    extension StockChartViewController {
        func setLineData(lineChartView: LineChartView, lineChartDataEntries: [ChartDataEntry], xAxis : [String], recentPrice : Double) {
            // Entry들을 이용해 Data Set 만들기(그런데 우리는 각 포인트를 나타내줄 필요가 없어서 지워줌
            let lineChartdataSet = LineChartDataSet(entries: lineChartDataEntries, label: "주가")
            lineChartdataSet.drawValuesEnabled = false
            lineChartdataSet.drawCirclesEnabled = false
            lineChartdataSet.colors = [.blue]
            //선택했을때 라인 지워주기
            lineChartdataSet.drawHorizontalHighlightIndicatorEnabled = false
    //        lineChartdataSet.drawVerticalHighlightIndicatorEnabled = false
            lineChartdataSet.highlightColor = .white
       
            // DataSet을 차트 데이터로 넣기
            let lineChartData = LineChartData(dataSet: lineChartdataSet)
            // 데이터 출력
            lineChartView.data = lineChartData
            // 선제거
            lineChartView.leftAxis.drawGridLinesEnabled = false
            lineChartView.rightAxis.drawGridLinesEnabled = false
            lineChartView.leftAxis.enabled = false // 왼쪽 label 값 지워주기
            lineChartView.rightAxis.enabled = false // right
            lineChartView.xAxis.enabled = false // 위쪽 label
            lineChartView.xAxis.drawGridLinesEnabled = false
            lineChartView.xAxis.drawAxisLineEnabled = false
            lineChartView.doubleTapToZoomEnabled = false
            // 아래 뜨는 어떤항목인지 알려주는 label 제거
            lineChartView.legend.enabled = false
            lineChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: xAxis)
            
            let marker = ChartMarker(pricedate: xAxis, recentprice: recentPrice)

            marker.chartView = lineChartView
            marker.chartx = view.frame.width - 10
            lineChartView.marker = marker
            lineChartView.drawMarkers = true
            // 데이터 소수점 제거
            let formatter = NumberFormatter()
            formatter.minimumFractionDigits = 0
            lineChartView.data?.setValueFormatter(DefaultValueFormatter(formatter:formatter))
        }
        // entry 만들기
        func entryData(yvalues: [Int]) -> [ChartDataEntry] {
            // entry 담을 array
            var lineDataEntries: [ChartDataEntry] = []
            // 담기
            for i in 0 ..< yvalues.count {
                let lineDataEntry = ChartDataEntry(x: Double(i), y: Double(yvalues[i]))
                lineDataEntries.append(lineDataEntry)
            }
            // 반환
            return lineDataEntries
        }
        private func setLineChartView() {
            stockPriceData.requestStockPrice(stockIdx: self.idx!, onCompleted: { (pricelists, transctiontime) in
                DispatchQueue.main.async {
                    self.view.addSubview(self.lineChartView)
                    let sortedtimeLists = transctiontime.sorted{$0.compare($1, options: .numeric) == .orderedAscending}
                    self.priceListDatas = pricelists
                    self.priceLabel.text = "\(self.priceListDatas.last!)원"
                    self.timeListDatas = sortedtimeLists
                    self.setLineData(lineChartView: self.lineChartView, lineChartDataEntries: self.entryData( yvalues: pricelists), xAxis: sortedtimeLists, recentPrice : Double(pricelists.last!))
                    self.setupTableView()
                }
            })
    //        EstatePriceData.requestStockPrice(EstateIdx: self.idx!, onCompleted: { (pricelists, transctiontime) in
    //            DispatchQueue.main.async {
    //                self.view.addSubview(self.lineChartView)
    //                self.setLineData(lineChartView: self.lineChartView, lineChartDataEntries: self.entryData( yvalues: pricelists), xAxis: transctiontime, recentPrice : Double(pricelists.last!))
    ////                self.lineChartView.snp.makeConstraints{
    ////                    $0.leading.trailing.equalToSuperview()
    ////                    $0.top.bottom.equalToSuperview().inset(140)
    ////                }
    //            }
    //        })    
        }
        
    }


    extension StockChartViewController {
        //MARK: - Configure
        private func configure(){
            lineImage.backgroundColor = .label
            [nameLabel, priceLabel, pricePercent,changeDate, sellButton, tableView, lineImage,dealLabel, revenueLabel, segmentCtrl,lineChartView]
                .forEach {view.addSubview($0)}
            nameLabel.snp.makeConstraints{
                $0.top.equalTo(view.safeAreaLayoutGuide.snp.top ).offset(10)
                $0.leading.equalToSuperview().inset(15)
            }
            priceLabel.snp.makeConstraints{
                $0.top.equalTo(nameLabel.snp.bottom).offset(8)
                $0.leading.equalTo(nameLabel.snp.leading)
            }
            pricePercent.snp.makeConstraints{
                $0.top.equalTo(nameLabel.snp.bottom).offset(9)
                $0.leading.equalTo(priceLabel.snp.trailing).offset(8)
            }
            changeDate.snp.makeConstraints{
                $0.top.equalTo(nameLabel.snp.bottom).offset(10)
                $0.leading.equalTo(pricePercent.snp.trailing).offset(8)
            }
            lineChartView.snp.makeConstraints{
                $0.top.equalTo(priceLabel.snp.bottom).offset(30)
                $0.leading.equalToSuperview().inset(15)
                $0.trailing.equalToSuperview().inset(15)
                $0.bottom.equalTo(view.snp.centerY).offset(20)
            }
            segmentCtrl.snp.makeConstraints{
                $0.top.equalTo(lineChartView.snp.bottom)
                $0.leading.equalToSuperview().inset(15)
                $0.trailing.equalToSuperview().inset(15)
            }
            revenueLabel.snp.makeConstraints{
                $0.leading.equalToSuperview().inset(33)
                $0.top.equalTo(segmentCtrl.snp.bottom).offset(24)
            }
            
            dealLabel.snp.makeConstraints{
                $0.top.equalTo(revenueLabel.snp.bottom).offset(24)
                $0.leading.equalToSuperview().inset(33)
            }
            lineImage.snp.makeConstraints{

                $0.leading.equalToSuperview().inset(33)
                $0.trailing.equalToSuperview().inset(33)
                $0.height.equalTo(1)
                $0.top.equalTo(dealLabel.snp.bottom).offset(4)
            }
            
            tableView.snp.makeConstraints{
                $0.top.equalTo(lineImage.snp.bottom)
                $0.bottom.equalTo(sellButton.snp.top).offset(-20)
                $0.leading.equalToSuperview().inset(33)
                $0.trailing.equalToSuperview().inset(33)
            }
            
            sellButton.snp.makeConstraints{
                $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-10)
                $0.leading.equalToSuperview().inset(33)
                $0.height.equalTo(48)
                $0.trailing.equalToSuperview().inset(33)
            }
        }
    }

