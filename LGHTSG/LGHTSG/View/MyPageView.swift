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
    
    var profileImageView2 : UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = image.frame.height/2
        image.layer.borderWidth = 1
        image.layer.masksToBounds = true
        image.contentMode = .scaleToFill
        image.layer.borderColor = UIColor.clear.cgColor // 원형 이미지의 테두리 제거
        image.clipsToBounds = true
        image.image = UIImage(named: "profile-money")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let button1 : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "mypage1"), for: .normal)
        return btn
    }()
    
    let button2 : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "mypage2"), for: .normal)
        return btn
    }()
    
    let button3 : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "mypage3"), for: .normal)
        return btn
    }()
    
    let logoutBtn : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "logout-btn"), for: .normal)
        return btn
    }()

    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(profileImageView2)
        addSubview(button1)
        addSubview(button2)
        addSubview(button3)
        addSubview(logoutBtn)
        
        let logoutLine = UnderlineView()
        addSubview(logoutLine)
        
        self.profileImageView2.snp.makeConstraints {
            $0.top.equalToSuperview().offset(150)
            $0.centerX.equalToSuperview()
        }
        
        self.button1.snp.makeConstraints {
            $0.top.equalTo(profileImageView2.snp.bottom).offset(50)
            $0.centerX.equalToSuperview()
        }
        
        self.button2.snp.makeConstraints {
            $0.top.equalTo(button1.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
        
        self.button3.snp.makeConstraints {
            $0.top.equalTo(button2.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
        
        self.logoutBtn.snp.makeConstraints{
            $0.bottom.equalToSuperview().offset(-50)
            $0.centerX.equalToSuperview()
        }
    }
        
    
    required init?(coder: NSCoder){
        fatalError("init?(coder:) is not Supported")
    }
}
