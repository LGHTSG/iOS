//
//  ChartViewController.swift
//  LGHTSG
//
//  Created by SunHo Lee on 2023/01/22.
//
import UIKit
import Charts
import Foundation
class ChartViewController : UIViewController {
        var stockPriceData = StockPriceModel()
        var EstatePriceData = EstatePriceModel()
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
            marker.chartheight = lineChartView.frame.height
            marker.chartView = lineChartView
            lineChartView.marker = marker
            
            
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
            EstatePriceData.requestStockPrice(EstateIdx: 1, onCompleted: { (pricelists, transctiontime) in
                DispatchQueue.main.async {
                    self.view.addSubview(self.lineChartView)
                    self.setLineData(lineChartView: self.lineChartView, lineChartDataEntries: self.entryData( yvalues: pricelists), xAxis: transctiontime, recentPrice : Double(pricelists.last!))
                    self.lineChartView.snp.makeConstraints{
                        $0.center.equalToSuperview()
                        $0.leading.trailing.equalToSuperview()
                        $0.top.bottom.equalToSuperview().inset(140)
                    }
                }
            })
        }
        
    }
    extension ChartViewController {
        func setDatePicker(){
            view.addSubview(segmentControl)
            segmentControl.snp.makeConstraints{
                    $0.bottom.equalToSuperview().inset(100)
                $0.leading.trailing.equalToSuperview()
                $0.height.equalTo(40)
            }
        }
    }


