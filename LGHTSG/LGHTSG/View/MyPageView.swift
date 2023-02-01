//
//  MyPageView.swift
//  LGHTSG
//
//  Created by 홍수정 on 2023/01/26.
//

import Foundation
import UIKit
import Alamofire
import SnapKit

class MyPageView : UIView {
    
    // MARK: 네비게이션 바 생성
    let navigationBar7 : UINavigationBar = {
        let navigationBar = UINavigationBar()
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        return navigationBar
    }()
    
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder){
        fatalError("init?(coder:) is not Supported")
    }
}
