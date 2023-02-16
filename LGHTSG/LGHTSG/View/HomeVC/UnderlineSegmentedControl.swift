//
//  LGHTSG
//
//  Created by SunHo Lee on 2023/01/13.
//
//
import UIKit
class UnderlineSegmentedControl: UISegmentedControl {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.removeBackgroundAndDivider()
  }
    
    
    
  override init(items: [Any]?) {
    super.init(items: items)
    self.removeBackgroundAndDivider()
      self.selectedSegmentIndex = 0
    self.setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name: "NanumSquareB", size: 16.0)], for: .normal)
      self.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.white, .font : UIFont(name: "NanumSquareB", size: 16.0)], for: .normal)
      self.setTitleTextAttributes(
        [
            NSAttributedString.Key.foregroundColor: UIColor.white,
          .font: UIFont(name: "NanumSquareB", size: 16.0)
        ],
        for: .selected
      )
  }
  required init?(coder: NSCoder) {
    fatalError()
  }
  
  func removeBackgroundAndDivider() {
    let image = UIImage()
    self.setBackgroundImage(image, for: .normal, barMetrics: .default)
    self.setBackgroundImage(image, for: .selected, barMetrics: .default)
    self.setBackgroundImage(image, for: .highlighted, barMetrics: .default)
    self.setDividerImage(image, forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
  }
}
