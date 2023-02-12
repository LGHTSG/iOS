//
//  StockDateSegmentControl.swift
//  LGHTSG
//
//  Created by SunHo Lee on 2023/01/19.
//
//b

import Foundation
import UIKit
final class StockDateSegmentControl : UnderlineSegmentedControl{

    override func removeBackgroundAndDivider() {
        super.removeBackgroundAndDivider()
        self.backgroundColor = .darkGray
        self.setTitleTextAttributes(
          [
            NSAttributedString.Key.foregroundColor: UIColor.lightGray,
            .font: UIFont(name: "NanumSquareEB", size: 14.0)
          ],
          for: .normal
          
        )
          self.setTitleTextAttributes(
            [
                NSAttributedString.Key.foregroundColor: UIColor.white,
              .font: UIFont(name: "NanumSquareEB", size: 14.0)
            ],
            for: .selected
          )
    }
}
