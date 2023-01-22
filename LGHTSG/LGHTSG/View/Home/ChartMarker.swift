//
//  BalloonMarker.swift
//  LGHTSG
//
//  Created by SunHo Lee on 2023/01/18.
//


import Foundation
import Charts
#if canImport(UIKit)
    import UIKit
#endif

class ChartMarker: MarkerView {
    var text = ""
    var pricedatelists = [String]()
    var priceDate = ""
    var pricetext = ""
    var pricepercent : String  = ""
    var recentprice : Double = 0.0
    var chartheight : Double = 0.0
    init(pricedate: [String], recentprice : Double) {
        super.init(frame: .zero)
        self.pricedatelists = pricedate
        self.recentprice = recentprice
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // highlight 클릭되면 제일먼저 값을 entry로 부터 가져오는데 entry에는 double밖에 넣지 못해 임의로 pricedatelist생성후 대입
    override func refreshContent(entry: ChartDataEntry, highlight: Highlight) {
        super.refreshContent(entry: entry, highlight: highlight)
        self.pricepercent = "\(String(format: "%.2f",(recentprice - entry.y) / recentprice * 100))%"
        text = "이때 샀다면 지금: \(self.pricepercent)"
        priceDate = pricedatelists[Int(entry.x)]
        pricetext = "\(Int(entry.y))원"
    }
    
    override func draw(context: CGContext, point: CGPoint) {
        super.draw(context: context, point: point)   
        var drawAttributes = [NSAttributedString.Key : Any]()
        drawAttributes[.font] = UIFont.systemFont(ofSize: 12)
        drawAttributes[.foregroundColor] = UIColor.white
        drawAttributes[.backgroundColor] = UIColor.clear
        self.bounds.size = ("\(text)" as NSString).size(withAttributes: drawAttributes)
        self.offset = CGPoint(x: -self.bounds.size.width / 2, y: -self.bounds.size.height * 2)
        let offset = self.offsetForDrawing(atPoint: point)
        drawText(text: ("\(text)" as NSString), rect: CGRect(origin: CGPoint(x: point.x + offset.x, y: chartheight ), size: self.bounds.size ), withAttributes: drawAttributes)
        self.bounds.size = ("\(pricetext)" as NSString).size(withAttributes: drawAttributes)
        self.offset = CGPoint(x: -self.bounds.size.width / 2, y: -self.bounds.size.height * 2 )
        drawAttributes[.font] = UIFont.systemFont(ofSize: 10)
        drawAttributes[.foregroundColor] = UIColor.lightGray
        drawText(text: "\(priceDate)" as NSString, rect: CGRect(origin: CGPoint(x: point.x + offset.x / 2, y: chartheight - offset.y / 2), size: self.bounds.size ), withAttributes: drawAttributes)
        drawAttributes[.font] = UIFont.systemFont(ofSize: 12)
        drawAttributes[.foregroundColor] = UIColor.white
        drawText(text: "\(pricetext)" as NSString, rect: CGRect(origin: CGPoint(x: point.x + offset.x / 2, y: chartheight - offset.y ), size: self.bounds.size ), withAttributes: drawAttributes)

//        let lineview : UIView = {
//            let uiview = UIView(frame: CGRect(x: point.x, y: 0, width: 100, height: chartheight - 30))
//            uiview.backgroundColor = .yellow
//            return uiview
//        }()
//        let centeredRect = CGRect(x: point.x, y: point.y, width: 1, height: chartheight-30)
//        lineview.draw(centeredRect)
    }
//    override func draw(_ rect: CGRect) {
//        super.draw(rect)
//    }
    func drawText(text: NSString, rect: CGRect, withAttributes attributes: [NSAttributedString.Key : Any]? = nil) {
        let size = text.size(withAttributes: attributes)
        let centeredRect = CGRect(x: rect.origin.x + (rect.size.width - size.width) / 2.0, y: rect.origin.y + (rect.size.height - size.height) / 2.0, width: size.width, height: size.height)
        text.draw(in: centeredRect, withAttributes: attributes)
    }
}
