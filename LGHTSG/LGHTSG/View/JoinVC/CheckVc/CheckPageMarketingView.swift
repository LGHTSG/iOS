//
//  CheckPageMarketingView.swift
//  LGHTSG
//
//  Created by 홍수정 on 2023/01/25.
//

import Foundation
import UIKit
import Alamofire
import SnapKit

class CheckPageMarketingView: UIView {
    
    // MARK: 네비게이션 바 생성
    let navigationBar6 : UINavigationBar = {
        let navigationBar = UINavigationBar()
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        return navigationBar
    }()
    
    let textboxImageView4 : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "text-long-box")
        return image
    }()
    
    let textContentLabel3 : UILabel = {
        let label = UILabel()
        label.text = "met,consecondimentum. Integer rhoncus ctetur adipiscing elit. Donec blandit egestas neque, id iaculis ex cursus et. In hac habitasse platea dictumst. Phasellus vel facilisis nisi, et convallis erat. Vivamus ultrices tellus massa, id laoreet neque elementum vitae. Vestibulum ultrices, mauris sit amet pretium volutpat, lorem enim ornare felis, in congue lacus sem met,consecondimentum. Integer rhoncus ctetur adipiscing elit. Donec blandit egestas neque, id iaculis ex cursus et. In hac habitasse platea dictumst. Phasellus vel facilisis nisi, et convallis erat. Vivamus ultrices tellus massa, id laoreet neque elementum vitae. Vestibulum ultrices, mauris sit amet pretium volutpat, lorem enim ornare felis, in congue lacus sem"
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    // MARK: 다음으로 버튼
    let nextBtnImageView5 : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "highlight-btn")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let nextLabel5 : UIButton = {
        let btn = UIButton()
        btn.setTitle("동의하기", for: .normal)
        btn.setTitleColor(.systemBlue, for: .normal)
        btn.titleLabel?.textAlignment = .center
        btn.titleLabel?.font = UIFont(name: "NanumSquareB", size: 15.0)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        addSubview(textboxImageView4)
        addSubview(textContentLabel3)
        
        addSubview(nextBtnImageView5)
        addSubview(nextLabel5)
        
        self.textboxImageView4.snp.makeConstraints{
            $0.top.equalToSuperview().offset(80)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
        }
        
        self.textContentLabel3.snp.makeConstraints{
            $0.top.equalTo(textboxImageView4.snp.top).offset(20)
            $0.left.equalTo(textboxImageView4.snp.left).offset(20)
            $0.right.equalTo(textboxImageView4.snp.right).offset(-20)
            $0.bottom.equalTo(textboxImageView4.snp.bottom).offset(-20)
        }

        self.nextBtnImageView5.snp.makeConstraints{
            $0.bottom.equalToSuperview().offset(-50)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
        }
        
        self.nextLabel5.snp.makeConstraints{
            $0.top.equalTo(nextBtnImageView5.snp.top).offset(10)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            
        }

    }
    
    required init?(coder: NSCoder){
        fatalError("init?(coder:) is not Supported")
    }
}
