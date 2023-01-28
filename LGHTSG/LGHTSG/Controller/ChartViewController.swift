//
//  ChartViewController.swift
//  LGHTSG
//
//  Created by SunHo Lee on 2023/01/22.
//
import UIKit
import Charts
import SnapKit
import Foundation
class ChartViewController : UIViewController {
    var stockPriceData = StockPriceModel()
    var EstatePriceData = EstatePriceModel()
    var nameText : String?
    var PriceText : String?
    var idx : Int?
    var pricePercentText : String?
    var changeDateText : String?
    var priceListDatas = [Int]()
    var timeListDatas = [String]()
    lazy var lineChartView : LineChartView = {
        let chartView = LineChartView()
        return chartView
    }()
    private lazy var nameLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.text = nameText
        return label
    }()
    private lazy var priceLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = UIColor.systemGray
        label.text = PriceText
        return label
    }()
    private lazy var pricePercent : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = UIColor.red
        label.text = pricePercentText
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
        let items = ["1일","1주", "3달", "1년", "3년"]
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
        seg.selectedSegmentIndex = 1
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
//        setupTableView()
    }
    //MARK: - TableViewSetting
    func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(EstateDetailCell.self, forCellReuseIdentifier: EstateDetailCell.identifier)
    }
    @objc func indexChanged(_ sender: UISegmentedControl){
        switch sender.selectedSegmentIndex{
        case 0:
            print("1주")
        case 1:
            print("3달")
        case 2:
            print("1년")
        case 3:
            print("5년")
        default:
            break
        }
    }
}
extension ChartViewController : UITableViewDelegate, UITableViewDataSource {
    //cell 높이조절
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 30
        }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timeListDatas.count    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EstateDetailCell.identifier, for: indexPath) as? EstateDetailCell else { return UITableViewCell() }
        
        cell.date.text = timeListDatas[indexPath.row]
        cell.date.textColor = .white
        cell.price.text = "\(priceListDatas[indexPath.row])원"
        cell.price.textColor = .white
        cell.buysell.text = "hello"
        cell.buysell.textColor = .white
        return cell
    }
}
extension ChartViewController {
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
        marker.chartheight = lineChartView.frame.origin.y - lineChartView.frame.height
        marker.chartView = lineChartView
        marker.chartx = lineChartView.frame.origin.x + lineChartView.frame.width
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
//        stockPriceData.requestStockPrice(stockIdx: 1, onCompleted: { (pricelists, transctiontime) in
//            DispatchQueue.main.async {
//                self.view.addSubview(self.lineChartView)
//                self.setLineData(lineChartView: self.lineChartView, lineChartDataEntries: self.entryData( yvalues: pricelists), xAxis: transctiontime, recentPrice : Double(pricelists.last!))
//                self.lineChartView.snp.makeConstraints{
//                    $0.center.equalToSuperview()
//                    $0.leading.trailing.equalToSuperview()
//                    $0.top.bottom.equalToSuperview().inset(140)
//                }
//            }
//        })
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
        stockPriceData.requestResellPrice(resellIdx: self.idx!, onCompleted: { (pricelists, transctiontime) in
            DispatchQueue.main.async {
                self.view.addSubview(self.lineChartView)
                self.priceListDatas = pricelists
                self.timeListDatas = transctiontime
                self.setLineData(lineChartView: self.lineChartView, lineChartDataEntries: self.entryData( yvalues: pricelists), xAxis: transctiontime, recentPrice : Double(pricelists.last!))
                self.setupTableView()
                
            }
        })
    }
    
}


extension ChartViewController {
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
            $0.bottom.equalTo(segmentCtrl.snp.top).inset(8)
        }
        segmentCtrl.snp.makeConstraints{
            $0.centerY.equalToSuperview()
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
            $0.bottom.equalTo(sellButton.snp.top).offset(-10)
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
