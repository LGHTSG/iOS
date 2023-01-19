//
//  StockDateSegmentControl.swift
//  LGHTSG
//
//  Created by SunHo Lee on 2023/01/19.
//

import Foundation
import UIKit
final class StockDateSegmentControl : UnderlineSegmentedControl{
    
    override func removeBackgroundAndDivider() {
        super.removeBackgroundAndDivider()
        self.backgroundColor = .darkGray
        self.setTitleTextAttributes(
          [
            NSAttributedString.Key.foregroundColor: UIColor.lightGray,
            .font: UIFont.systemFont(ofSize: 16, weight: .semibold)
          ],
          for: .normal
          
        )
          self.setTitleTextAttributes(
            [
                NSAttributedString.Key.foregroundColor: UIColor.tintColor,
              .font: UIFont.systemFont(ofSize: 16, weight: .semibold)
            ],
            for: .selected
          )
    }
}
