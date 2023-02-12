//
//  CheckPagePrivacyView.swift
//  LGHTSG
//
//  Created by 홍수정 on 2023/01/25.
//

import Foundation
import UIKit
import Alamofire
import SnapKit

class CheckPagePrivacyView: UIView {
    
    // MARK: 네비게이션 바 생성
    let navigationBar5 : UINavigationBar = {
        let navigationBar = UINavigationBar()
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        return navigationBar
    }()
    
    let textboxImageView3 : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "text-long-box")
        return image
    }()
    
    
    //MARK: let scrollview
    let scrollView2: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.delaysContentTouches = true
        scrollView.backgroundColor = .clear
        return scrollView
    }()
        
        
    let scrollAddView2: UIView = {
        let view = UIView()
        return view
    }()
    
    let textContentLabel2 : UILabel = {
        let label = UILabel()
        label.text = "< 라고할때살걸 >('https://api.lghtsg.site'이하 '라고할때살걸')은(는) 「개인정보 보호법」 제30조에 따라 정보주체의 개인정보를 보호하고 이와 관련한 고충을 신속하고 원활하게 처리할 수 있도록 하기 위하여 다음과 같이 개인정보 처리방침을 수립·공개합니다\n\n제1조(개인정보의 처리목적)\n< 라고할때살걸 >(이)가 개인정보 보호법 제32조에 따라 등록․공개하는 개인정보파일의 처리목적은 다음과 같습니다.\n\n1. 개인정보 파일명 : 라고할때살걸 사용자 정보\n개인정보의 처리목적 : 서비스 기능 제공을 위한 사용자 구분\n수집방법 : 앱\n보유근거 : 서비스 기능 제공을 위한 사용자 구분\n보유기간 : 1년\n관련법령 : 신용정보의 수집/처리 및 이용 등에 관한 기록 : 3년\n\n\n제2조(처리하는 개인정보의 항목)\n\n① < 라고할때살걸 >은(는) 다음의 개인정보 항목을 처리하고 있습니다.\n\n1< 라고할때살걸 사용자 정보 >\n필수항목 : 이메일, 비밀번호, 로그인ID, 이름, 서비스 이용 기록, 쿠키\n선택항목 :\n        1. 개인정보분쟁조정위원회 : (국번없이) 1833-6972 (www.kopico.go.kr)\n"
        label.textColor = .white
        label.numberOfLines = 0
        label.font = UIFont(name: "NanumSquareR", size: 13.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: 다음으로 버튼
    let nextBtnImageView4 : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "highlight-btn")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let nextLabel4 : UIButton = {
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
        
        addSubview(textboxImageView3)
        addSubview(textContentLabel2)

        textContentLabel2.addSubview(scrollView2)
        
        addSubview(nextBtnImageView4)
        addSubview(nextLabel4)
        
        self.textboxImageView3.snp.makeConstraints{
            $0.top.equalToSuperview().offset(80)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
        }

        self.textContentLabel2.snp.makeConstraints{
            $0.top.equalTo(textboxImageView3.snp.top).offset(20)
            $0.left.equalTo(textboxImageView3.snp.left).offset(20)
            $0.right.equalTo(textboxImageView3.snp.right).offset(-20)
            $0.bottom.equalTo(textboxImageView3.snp.bottom).offset(-20)
        }
        
        self.nextBtnImageView4.snp.makeConstraints{
            $0.bottom.equalToSuperview().offset(-50)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
        }
        
        self.nextLabel4.snp.makeConstraints{
            $0.top.equalTo(nextBtnImageView4.snp.top).offset(10)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            
        }
        
        
        scrollView2.leadingAnchor.constraint(equalTo: textContentLabel2.leadingAnchor).isActive = true
        scrollView2.trailingAnchor.constraint(equalTo: textContentLabel2.trailingAnchor).isActive = true
        scrollView2.topAnchor.constraint(equalTo: textContentLabel2.bottomAnchor).isActive = true
        scrollView2.bottomAnchor.constraint(equalTo: textContentLabel2.bottomAnchor).isActive = true

    }
    
    required init?(coder: NSCoder){
        fatalError("init?(coder:) is not Supported")
    }
}
