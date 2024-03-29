


import Charts
import UIKit


class ChartMarker: MarkerView {
    var text = ""
    var pricedatelists = [String]()
    var priceDate = ""
    var pricetext = ""
    var price : Int?
    var pricepercent : String  = ""
    var recentprice : Double = 0.0
    
    var chartx: Double = 0.0
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
//        if (self.pricepercent[self.pricepercent.startIndex] == "-") {
//            let attributeStr = NSMutableAttributedString(string: text)
//        }
        text = "이때 샀다면 지금 \(self.pricepercent)"
        if(priceDate != pricedatelists[Int(entry.x)]){
            let data = [pricedatelists[Int(entry.x)] : Int(entry.y)]
            NotificationCenter.default.post(name: Notification.Name("markerdata"), object: nil, userInfo: data)
        }
        priceDate = pricedatelists[Int(entry.x)]
        price = Int(entry.y)
        pricetext = "\(price!)원"
    }
    
    override func draw(context: CGContext, point: CGPoint) {
        super.draw(context: context, point: point)   
        var drawAttributes = [NSAttributedString.Key : Any]()
        drawAttributes[.font] = UIFont(name: "NanumSquareEB", size: 12)
        drawAttributes[.foregroundColor] = UIColor.systemGreen
        drawAttributes[.backgroundColor] = UIColor.clear
        self.bounds.size = ("\(text)" as NSString).size(withAttributes: drawAttributes)
        self.offset = CGPoint(x: -self.bounds.size.width / 2, y: self.bounds.size.height * 2)
        if point.x + offset.x < 0.0
        {
            offset.x = -point.x
        }
        else if point.x + self.bounds.size.width + offset.x > chartx
        {
            offset.x = chartx - point.x - self.bounds.size.width
        }
        drawText(text: " \(text) " as NSString, rect: CGRect(origin: CGPoint(x: point.x + offset.x, y:  0), size: self.bounds.size), withAttributes: drawAttributes)
        self.bounds.size = ("\(pricetext)" as NSString).size(withAttributes: drawAttributes)
        drawAttributes[.font] = UIFont(name: "NanumSquareEB", size: 10)
        drawAttributes[.foregroundColor] = UIColor.lightGray
        drawText(text: "\(priceDate)" as NSString, rect: CGRect(origin: CGPoint(x: point.x + offset.x / 2, y:  offset.y), size: self.bounds.size ), withAttributes: drawAttributes)
        drawAttributes[.font] = UIFont(name: "NanumSquareEB", size: 12)
        drawAttributes[.foregroundColor] = UIColor.white
        drawText(text: "\(pricetext)" as NSString, rect: CGRect(origin: CGPoint(x: point.x + offset.x / 2, y: offset.y / 2 ), size: self.bounds.size ), withAttributes: drawAttributes)
//        let data = [priceDate : price!]
//        NotificationCenter.default.post(name: Notification.Name("markerdata"), object: nil, userInfo: data)

    }
    override func draw(_ rect: CGRect) {
        super.draw(rect)
    }
    func drawText(text: NSString, rect: CGRect, withAttributes attributes: [NSAttributedString.Key : Any]? = nil) {
        let size = text.size(withAttributes: attributes)
        let centeredRect = CGRect(x: rect.origin.x + (rect.size.width - size.width) / 2, y: rect.origin.y + (rect.size.height - size.height) / 2  , width: size.width, height: size.height)
        text.draw(in: centeredRect, withAttributes: attributes)
    }
}
