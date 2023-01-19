//
//  ExploreViewController.swift
//  LGHTSG
//
//  Created by SunHo Lee on 2023/01/11.
//

import UIKit
import Charts
import SnapKit
//struct ChartData : LineChartData{
//    var xvalue: String
//    var yvalue: Double
//}
final class ExploreViewController : UIViewController{
    var months : [Double] = [1, 2, 3, 4, 5, 6, 7 , 8, 9, 10, 11, 12, 13, 14,15]
    var unitsSold : [Double] = [898900, 8182000,333300, 739200, 980000, 3199000,123300,122220,125600,320000,123123,4124000, 122330, 12312, 124241]
    var segmentControl = StockDateSegmentControl(items: ["1주", "3달", "1년","5년"])
    
    lazy var lineChartView : LineChartView = {
        let chartView = LineChartView()
        return chartView
    }()
    override func viewDidLoad(){
        super.viewDidLoad()
        setDatePicker()
        setLineChartView()
    }
}

extension ExploreViewController {
    func setLineData(lineChartView: LineChartView, lineChartDataEntries: [ChartDataEntry]) {
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
        // 아래 뜨는 어떤항목인지 알려주는 label 제거
        lineChartView.legend.enabled = false
        let marker = ChartMarker()
        marker.chartheight = lineChartView.frame.height
        marker.chartView = lineChartView
        lineChartView.marker = marker
        
        
        // 데이터 소수점 제거
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        lineChartView.data?.setValueFormatter(DefaultValueFormatter(formatter:formatter))
    }
    // entry 만들기
    func entryData(xvalues: [Double], yvalues: [Double]) -> [ChartDataEntry] {
        // entry 담을 array
        var lineDataEntries: [ChartDataEntry] = []
        // 담기
        for i in 0 ..< yvalues.count {
            let lineDataEntry = ChartDataEntry(x: xvalues[i], y: yvalues[i])
            lineDataEntries.append(lineDataEntry)
        }
        // 반환
        return lineDataEntries
    }
    private func setLineChartView() {
        
        view.addSubview(lineChartView)
        setLineData(lineChartView: lineChartView, lineChartDataEntries: self.entryData(xvalues : months, yvalues: self.unitsSold))
        lineChartView.snp.makeConstraints{
            $0.center.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.top.bottom.equalToSuperview().inset(140)
        
        }
        
    }
    
}
extension ExploreViewController {
    func setDatePicker(){
        view.addSubview(segmentControl)
        segmentControl.snp.makeConstraints{
                $0.bottom.equalToSuperview().inset(100)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(40)
        }
    }
}
