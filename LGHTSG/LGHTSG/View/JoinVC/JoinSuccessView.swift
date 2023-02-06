
//
//  JoinSuccessView.swift
//  LGHTSG
//
//
import Foundation
import UIKit
import Alamofire
import SnapKit

class JoinSuccessView : UIView {
    
    let iconVerticalImageView : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "icon_vertical")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    
    let successLabel : UILabel = {
        let label = UILabel()
        label.text = "회원가입이 완료되었습니다."
        label.textColor = .white
        label.font = UIFont(name: "NanumSquareB", size: 16.0)
        return label
    }()
    
    let successContent : UILabel = {
        let label = UILabel()
        label.text = "라고할때살걸과 함께\n쉬운 금융 습관을 시작하세요!"
        label.textColor = .white
        label.numberOfLines = 0
        label.font = UIFont(name: "NanumSquareR", size: 14.0)
        label.textAlignment = .center
        return label
    }()
    
    let successBtnImageView : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "success-btn")
        return image
    }()
    
    let successBtn : UIButton = {
        let label = UIButton()
        label.setTitle("라고할때살걸 시작하기", for: .normal)
        label.titleLabel?.font = UIFont(name: "NanumSquareB", size: 16.0)
        label.titleLabel?.textColor = .white
        label.titleLabel?.textAlignment = .center

        return label
    }()

    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        addSubview(iconVerticalImageView)
        addSubview(successLabel)
        addSubview(successContent)
        addSubview(successBtnImageView)
        addSubview(successBtn)
        
        self.iconVerticalImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(250)
            $0.centerX.equalToSuperview()
        }
        
        self.successLabel.snp.makeConstraints{
            $0.top.equalTo(iconVerticalImageView.snp.bottom).offset(100)
            $0.centerX.equalToSuperview()
        }
        
        self.successContent.snp.makeConstraints{
            $0.top.equalTo(successLabel.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
        
        
        self.successBtnImageView.snp.makeConstraints{
            $0.bottom.equalToSuperview().offset(-50)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
        }
        
        self.successBtn.snp.makeConstraints{
            $0.top.equalTo(successBtnImageView).offset(10)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
        }

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
