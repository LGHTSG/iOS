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
        private var mytoken = UserDefaults.standard.string(forKey: "savedToken")
        var idx : Int?
        var pricePercentText : String?
        var changeDateText : String?
        var priceListDatas = [Int]()
        var timeListDatas = [String]()
        var temppriceListDatas = [Int]()
        var temptimeListDatas = [String]()
        var tradeListData = [TradeHistroy.HistoryBody]()
        private var markerPrice : Int?
        private var markerDate : String?
        private var sellMode : Bool?
        private let todayDate = Date()
        var dateFormatter : DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }()
        lazy var lineChartView : LineChartView = {
            let chartView = LineChartView()
            return chartView
        }()
        private lazy var nameLabel : UILabel = {
            let label = UILabel()
            label.font = UIFont(name: "NanumSquareEB", size: 17.0)
            label.textColor  = UIColor.white
            label.text = nameText
            return label
        }()
        private lazy var priceLabel : UILabel = {
            let label = UILabel()
            label.font = UIFont(name: "NanumSquareB", size: 14.0)
            label.textColor = UIColor.systemGray
           
            return label
        }()
        private lazy var pricePercent : UILabel = {
            let label = UILabel()
            label.font = UIFont(name: "NanumSquareEB", size: 12.0)
            label.text = pricePercentText
            if (label.text!.prefix(1) == "-"){
                label.textColor = UIColor.systemBlue
            }else{
                label.textColor = UIColor.systemRed
            }
            return label
        }()
        private lazy var changeDate : UILabel = {
            let label = UILabel()
            label.font = UIFont(name: "NanumSquareB", size: 12.0)
            label.textColor = UIColor.systemGray
            label.text = changeDateText
            return label
        }()
        //MARK: - Label
        private lazy var dealLabel: UILabel = {
            let label = UILabel()
            label.text = "거래 이력"
            label.font = UIFont(name: "NanumSquareEB", size: 14.0)
            label.textColor = .white
            return label
        }()
        
        private lazy var revenueLabel: UILabel = {
            let label = UILabel()
            label.textColor = .systemBlue
            label.font = UIFont(name: "NanumSquareEB", size: 16.0)
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
            seg.selectedSegmentTintColor = UIColor(named: "dropdown")
            seg.setTitleTextAttributes(
              [
                  NSAttributedString.Key.foregroundColor: UIColor.white,
                .font: UIFont(name: "NanumSquareEB", size: 14.0)
              ],
              for: .selected
            )
            seg.setTitleTextAttributes(
              [
                  NSAttributedString.Key.foregroundColor: UIColor.systemGray,
                .font: UIFont(name: "NanumSquareEB", size: 14.0)
              ],
              for: .normal
            )
            seg.selectedSegmentIndex = 3
            return seg
        }()
        
        //MARK: - Button
        private lazy var sellButton: UIButton = {
            let btn = UIButton()
            var config = UIButton.Configuration.filled()
            config.attributedTitle = "원하시는 구매시점을 클릭해주세요"
            config.attributedTitle?.font = UIFont(name: "NanumSquareEB", size: 14.0)
            btn.configuration = config
            btn.layer.cornerRadius = 10
            btn.backgroundColor = .systemBlue
            btn.tintColor = .systemBlue
            btn.addTarget(self, action: #selector(sellbtnclicked), for: .touchUpInside)
            return btn
            
        }()
        //MARK: - ButtonCustom
    private func setSellButton(){
        if(sellMode == true){
            var config = UIButton.Configuration.plain()
            config.titleAlignment = .center
            if let markerDate = self.markerDate {
                var titleAttribute = AttributeContainer()
                titleAttribute.font = UIFont(name: "NanumSquareB", size: 10.0)
                config.attributedTitle = AttributedString(markerDate, attributes: titleAttribute)
                config.titlePadding = 3.0
            }
            var subtitleAttribute = AttributeContainer()
            subtitleAttribute.font = UIFont(name: "NanumSquareEB", size: 15.0)
            config.attributedSubtitle = AttributedString("판매", attributes: subtitleAttribute)
            self.sellButton.configuration = config
            self.sellButton.backgroundColor = .white
        }
        else{
            var config = UIButton.Configuration.filled()
            config.titleAlignment = .center
            if let markerDate = self.markerDate {
                var titleAttribute = AttributeContainer()
                titleAttribute.font = UIFont(name: "NanumSquareB", size: 10.0)
                config.attributedTitle = AttributedString(markerDate, attributes: titleAttribute)
                config.titlePadding = 3.0
            }
            var subtitleAttribute = AttributeContainer()
            subtitleAttribute.font = UIFont(name: "NanumSquareEB", size: 15.0)
            subtitleAttribute.backgroundColor  = .white
            config.attributedSubtitle = AttributedString("구매", attributes: subtitleAttribute)
            self.sellButton.configuration = config
            self.sellButton.backgroundColor = .systemBlue
        }
    }
        //MARK: - MarkerDatachange
    @objc func markerchange(_ notification : Notification){
        if let getValue = notification.userInfo as? [String : Int]{
            for (date, price ) in getValue {
                self.markerPrice = price
                self.markerDate = date
            }
            setSellButton()
        }
    }
        //MARK: - TableView
        private lazy var tableView: UITableView = {
            let table = UITableView()
            table.backgroundColor = .black
            
            return table
            
        }()
        
        //MARK: - LifeCycle
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .black

            setLineChartView()
            NotificationCenter.default.addObserver(self, selector: #selector(markerchange(_:)), name: Notification.Name("markerdata"), object: nil)
            

        }
        //MARK: - GETTradeLists
        private func getTradeLists(){
            let stockModel = StocktradeModel()
            stockModel.reqeustTradeHistory(assetIdx: self.idx!, catgegory: "stock", token: self.mytoken!){
                data in
                if(data.header.resultCode == 4205){
                    self.sellMode = false
                    
                }
                else if(data.header.resultCode == 1000){
                    self.tradeListData = data.body!
                    //현재 가지고 있는 경우
                    if(data.body!.last?.sellCheck == 0){
                        
                        let subData = Double( self.priceListDatas.last! - data.body!.last!.price ) / Double(data.body!.last!.price) * 100
                        if subData > 0 {
                            self.revenueLabel.textColor = .systemBlue
                        }
                        else {
                            self.revenueLabel.textColor = .systemRed
                        }
                        
                        
                        
                        self.revenueLabel.text = "구매시점에 비해서 \(String(format: "%.2f", Double(( self.priceListDatas.last! - data.body!.last!.price )) / Double(data.body!.last!.price) * 100))% "
                        self.sellMode = true
                    }else{
                        self.sellMode = false
                    }
                    self.setSellButton()
                    self.tableView.reloadData()
                }
            }
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
                    pricePercent.textColor = UIColor.systemBlue
                }
                else{
                    pricePercent.textColor = UIColor.systemRed
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
                    pricePercent.textColor = UIColor.systemBlue
                }
                else{
                    pricePercent.textColor = UIColor.systemRed
                }
                tableView.reloadData()
            case 2:
                changeDate.text = "일년 대비"
                let yearagoday = Calendar.current.date(byAdding: .day, value: -365, to: todayDate)!
                let yearagodate = dateFormatter.string(from: yearagoday)
                // 만약 첫 거래가1년보다 최근인경우
                let firstTradeDate = timeListDatas[0]
                let fistDate = dateFormatter.date(from: firstTradeDate[0..<10])!
                if(fistDate > yearagoday ) {
                    
                    let firstTradePrice = priceListDatas[0]
                    var tempTradeDate = [String]()
                    var tempTradePrice = [Int ]()
                    var plusweek = yearagoday
                    
                    while(true){
                        plusweek = Calendar.current.date(byAdding: .day, value: 7, to: plusweek)!
                        if(plusweek < fistDate) {
                            tempTradeDate.append(dateFormatter.string(from: plusweek))
                            tempTradePrice.append(firstTradePrice)
                        }
                        else{break}
                    }
                    timeListDatas.insert(contentsOf: tempTradeDate, at: 0)
                    priceListDatas.insert(contentsOf: tempTradePrice, at: 0)
                    self.setLineData(lineChartView: self.lineChartView, lineChartDataEntries: self.entryData( yvalues: priceListDatas), xAxis: timeListDatas, recentPrice : Double(priceListDatas.last!))
                    tableView.reloadData()
                }
                else{
                    var estimateDate : String?
                    for k in timeListDatas {
                        if k >= yearagodate{
                            estimateDate = k
                            break
                        }
                    }
                    let firstindex = timeListDatas.firstIndex(of: estimateDate!)!
                    temptimeListDatas = Array(timeListDatas.dropFirst(firstindex))
                    temppriceListDatas = Array(priceListDatas.dropFirst(firstindex))
                    self.setLineData(lineChartView: self.lineChartView, lineChartDataEntries: self.entryData( yvalues: temppriceListDatas), xAxis: temptimeListDatas, recentPrice : Double(temppriceListDatas.last!))
                    pricePercent.text =  "\(String(format: "%.2f", Double((temppriceListDatas.last! - temppriceListDatas[0])) / Double(temppriceListDatas[0]) * 100))%"
                    if(pricePercent.text?.prefix(1) == "-"){
                        pricePercent.textColor = UIColor.systemBlue
                    }
                    else{
                        pricePercent.textColor = UIColor.systemRed
                    }
                    tableView.reloadData()
                }
            case 3:
                changeDate.text = "5년 대비"
                let yearagoday = Calendar.current.date(byAdding: .day, value: -1825, to: todayDate)!
                let yearagodate = dateFormatter.string(from: yearagoday)
                // 만약 첫 거래가5년보다 최근인경우
                let firstTradeDate = timeListDatas[0]
                let fistDate = dateFormatter.date(from: firstTradeDate[0..<10])!
                if(fistDate > yearagoday ) {
                    let firstTradePrice = priceListDatas[0]
                    var tempTradeDate = [String]()
                    var tempTradePrice = [Int ]()
                    var plusweek = yearagoday
                    while(true){
                        plusweek = Calendar.current.date(byAdding: .day, value: 30, to: plusweek)!
                        if(plusweek < fistDate) {
                            tempTradeDate.append(dateFormatter.string(from: plusweek))
                            tempTradePrice.append(firstTradePrice)
                        }
                        else{break}
                    }
                    timeListDatas.insert(contentsOf: tempTradeDate, at: 0)
                    priceListDatas.insert(contentsOf: tempTradePrice, at: 0)
                    
                    self.setLineData(lineChartView: self.lineChartView, lineChartDataEntries: self.entryData( yvalues: priceListDatas), xAxis: timeListDatas, recentPrice : Double(priceListDatas.last!))
                    pricePercent.text =  "\(String(format: "%.2f", Double((temppriceListDatas.last! - temppriceListDatas[0])) / Double(temppriceListDatas[0]) * 100))%"
                    if(pricePercent.text?.prefix(1) == "-"){
                        pricePercent.textColor = UIColor.systemBlue
                    }
                    else{
                        pricePercent.textColor = UIColor.systemRed
                    }
                    tableView.reloadData()
                }
                else{
                    var estimateDate : String?
                    for k in timeListDatas {
                        if k >= yearagodate{
                            estimateDate = k
                            break
                        }
                    }
                    let firstindex = timeListDatas.firstIndex(of: estimateDate!)!
                    temptimeListDatas = Array(timeListDatas.dropFirst(firstindex))
                    temppriceListDatas = Array(priceListDatas.dropFirst(firstindex))
                    self.setLineData(lineChartView: self.lineChartView, lineChartDataEntries: self.entryData( yvalues: temppriceListDatas), xAxis: temptimeListDatas, recentPrice : Double(temppriceListDatas.last!))
                    pricePercent.text =  "\(String(format: "%.2f", Double((temppriceListDatas.last! - temppriceListDatas[0])) / Double(temppriceListDatas[0]) * 100))%"
                    if(pricePercent.text?.prefix(1) == "-"){
                        pricePercent.textColor = UIColor.systemBlue
                    }
                    else{
                        pricePercent.textColor = UIColor.systemRed
                    }
                    tableView.reloadData()
                }
            default:
                break
            }
        }
    //MARK: - btnclickevent
    @objc func sellbtnclicked(){
            let trademodel = StocktradeModel()
            if let markerDate = self.markerDate {
                if(sellMode == true){
                    trademodel.requestSellstock(assetIdx: self.idx!, category: "stock", price: self.markerPrice!, transactionTime: markerDate, token: mytoken!){
                        data in
                        if(data.header.resultCode == 4009){
                            let alertv = UIAlertController(title: "Error", message: "판매하려는 시기 이후에 구매하였습니다.", preferredStyle: UIAlertController.Style.alert)
                            alertv.addAction(UIAlertAction(title: "OK", style: .default))
                            self.present(alertv, animated: true)
                        }
                        else if (data.header.resultCode == 4006){
                            let alertv = UIAlertController(title: "Error", message: "이미 판매를 한 상품입니다.", preferredStyle: UIAlertController.Style.alert)
                            alertv.addAction(UIAlertAction(title: "OK", style: .default))
                            self.present(alertv, animated: true)
                        }
                        else{
                            let alertv = UIAlertController(title: "판매완료", message: "판매가 완료되었습니다", preferredStyle: UIAlertController.Style.alert)
                            alertv.addAction(UIAlertAction(title: "OK", style: .default))
                            self.present(alertv, animated: true){
                                self.getTradeLists()
                                self.tableView.reloadData()
                            }
                        }}
                }else{
                    //구매하기
                    trademodel.requestBuystock(assetIdx: self.idx!, category: "stock", price: self.markerPrice!, transactionTime: markerDate, token: mytoken!)  {
                        data in
                        if(data.header.resultCode == 4005){
                            let alertv = UIAlertController(title: "Error", message: "이미 구매를 한 상품입니다.", preferredStyle: UIAlertController.Style.alert)
                            alertv.addAction(UIAlertAction(title: "OK", style: .default))
                            self.present(alertv, animated: true)
                        }
                        else if(data.header.resultCode == 1000){
                            let alertv = UIAlertController(title: "구매완료 ", message: "구매가 완료되었습니다", preferredStyle: UIAlertController.Style.alert)
                            alertv.addAction(UIAlertAction(title: "OK", style: .default))
                            self.present(alertv, animated: true)
                            self.getTradeLists()
                            self.tableView.reloadData()
                        }
                    }
                }
            }
           
        }
    }
    extension StockChartViewController : UITableViewDelegate, UITableViewDataSource {
        //cell 높이조절
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
                return 30
            }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return tradeListData.count    }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: EstateDetailCell.identifier, for: indexPath) as? EstateDetailCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            
            cell.date.font = UIFont(name: "NanumSquareEB", size: 13)
            cell.price.font = UIFont(name: "NanumSquareEB", size: 13)
            cell.buysell.font = UIFont(name: "NanumSquareEB", size: 13)

            cell.date.text = tradeListData[indexPath.row].transactionTime
            cell.date.textColor = .white
            cell.price.text = "\(tradeListData[indexPath.row].price)원"
            cell.price.textColor = .white
            if(tradeListData[indexPath.row].sellCheck == 0 ){
                cell.buysell.text = "구매"
                cell.buysell.textColor = .systemRed
            }
            else if(tradeListData[indexPath.row].sellCheck == 1){
                cell.buysell.text = "판매"
                cell.buysell.textColor = .systemBlue
            }
            return cell
        }
    }
    extension StockChartViewController {
        func setLineData(lineChartView: LineChartView, lineChartDataEntries: [ChartDataEntry], xAxis : [String], recentPrice : Double) {
            // Entry들을 이용해 Data Set 만들기(그런데 우리는 각 포인트를 나타내줄 필요가 없어서 지워줌
            let lineChartdataSet = LineChartDataSet(entries: lineChartDataEntries, label: "주가")
            lineChartdataSet.drawValuesEnabled = false
            lineChartdataSet.drawCirclesEnabled = false
            lineChartdataSet.colors = [.systemBlue]
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
                    self.priceLabel.font = UIFont(name: "NanumSquareB", size: 13)
                    self.priceLabel.text = "\(self.priceListDatas.last!)원"
                    self.timeListDatas = sortedtimeLists
                    self.setLineData(lineChartView: self.lineChartView, lineChartDataEntries: self.entryData( yvalues: pricelists), xAxis: sortedtimeLists, recentPrice : Double(pricelists.last!))
                    self.setupTableView()
                    self.getTradeLists()
                    
                    self.configure()
                }
            })

        }
        
    }


    extension StockChartViewController {
        //MARK: - Configure
        private func configure(){
            lineImage.backgroundColor = .white
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

extension String {
    subscript (bounds: CountableClosedRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start...end])
    }

    subscript (bounds: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start..<end])
    }
}
