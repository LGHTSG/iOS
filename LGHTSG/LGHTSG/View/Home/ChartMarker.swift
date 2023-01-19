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
    var pricetext = ""
    var chartheight : Double = 0.0
    override func refreshContent(entry: ChartDataEntry, highlight: Highlight) {
        super.refreshContent(entry: entry, highlight: highlight)
        text = "이때 샀다면 지금: -4.9% "
        pricetext = "\(entry.y)원"
    }

    override func draw(context: CGContext, point: CGPoint) {
        super.draw(context: context, point: point)   
        var drawAttributes = [NSAttributedString.Key : Any]()
        drawAttributes[.font] = UIFont.systemFont(ofSize: 15)
        drawAttributes[.foregroundColor] = UIColor.white
        drawAttributes[.backgroundColor] = UIColor.clear
        self.bounds.size = ("\(text)" as NSString).size(withAttributes: drawAttributes)
        self.offset = CGPoint(x: -self.bounds.size.width / 2, y: -self.bounds.size.height * 2)
        let offset = self.offsetForDrawing(atPoint: point)
        drawText(text: "\(text)" as NSString, rect: CGRect(origin: CGPoint(x: point.x + offset.x, y: chartheight ), size: self.bounds.size ), withAttributes: drawAttributes)
        self.bounds.size = ("\(pricetext)" as NSString).size(withAttributes: drawAttributes)
        self.offset = CGPoint(x: -self.bounds.size.width / 2, y: -self.bounds.size.height * 2 )
        drawText(text: "\(pricetext)" as NSString, rect: CGRect(origin: CGPoint(x: point.x + offset.x / 2, y: chartheight - offset.y / 2 ), size: self.bounds.size ), withAttributes: drawAttributes)
        let lineview : UIView = {
            let uiview = UIView(frame: CGRect(x: point.x, y: 0, width: 100, height: chartheight - 30))
            uiview.backgroundColor = .yellow
            return uiview
        }()
        let centeredRect = CGRect(x: point.x, y: point.y, width: 1, height: chartheight-30)
        lineview.draw(centeredRect)
    }
    override func draw(_ rect: CGRect) {
        super.draw(rect)
    }
    func drawText(text: NSString, rect: CGRect, withAttributes attributes: [NSAttributedString.Key : Any]? = nil) {
        let size = text.size(withAttributes: attributes)
        let centeredRect = CGRect(x: rect.origin.x + (rect.size.width - size.width) / 2.0, y: rect.origin.y + (rect.size.height - size.height) / 2.0, width: size.width, height: size.height)
        text.draw(in: centeredRect, withAttributes: attributes)
        

    }
}
