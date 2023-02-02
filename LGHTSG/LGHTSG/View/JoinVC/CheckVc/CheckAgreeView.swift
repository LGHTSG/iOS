//
//  CheckAgreeView.swift
//  LGHTSG
//
//  Created by 홍수정 on 2023/01/25.
//

import Foundation
import UIKit
import Alamofire
import SnapKit

class CheckAgreeView: UIView {
    
    
    var allChecked:Bool = false
    var isChecked:Bool = false
    var isChecked2:Bool = false
    var isChecked3:Bool = false
    var isChecked4:Bool = false
    
    
    // MARK: 네비게이션 바 생성
    let navigationBar3 : UINavigationBar = {
        let navigationBar = UINavigationBar()
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        return navigationBar
    }()

    
    let lineImageView : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "line")
        return image
    }()
    
    
    let agreeLabel : UILabel = {
        let label = UILabel()
        label.text = "약관 동의"
        label.textColor = .white
        label.font = UIFont(name: "NanumSquareB", size: 18.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let allAgreeLabel : UILabel = {
        let label = UILabel()
        label.text = "모두 동의하기"
        label.textColor = .white
        label.font = UIFont(name: "NanumSquareR", size: 15.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: 체크박스
    let checkBox: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "not-check-box"), for: .normal)
        btn.heightAnchor.constraint(equalToConstant: 30).isActive = true
        btn.widthAnchor.constraint(equalToConstant: 30).isActive = true
        btn.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let checkBox2: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "not-check-box"), for: .normal)
        btn.heightAnchor.constraint(equalToConstant: 30).isActive = true
        btn.widthAnchor.constraint(equalToConstant: 30).isActive = true
        btn.addTarget(self, action: #selector(buttonClicked2), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let checkBox3: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "not-check-box"), for: .normal)
        btn.heightAnchor.constraint(equalToConstant: 30).isActive = true
        btn.widthAnchor.constraint(equalToConstant: 30).isActive = true
        btn.addTarget(self, action: #selector(buttonClicked3), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    
    let checkBox4: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "not-check-box"), for: .normal)
        btn.heightAnchor.constraint(equalToConstant: 30).isActive = true
        btn.widthAnchor.constraint(equalToConstant: 30).isActive = true
        btn.addTarget(self, action: #selector(buttonClicked4), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    
    // MARK: 텍스트 상자
    let textboxView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "text-box")
        return image
    }()
    
    let textboxContent: UILabel = {
        let label = UILabel()
        label.text = "met,consecondimentum. Integer rhoncus ctetur adipiscing elit. Donec blandit egestas neque, id iaculis ex cursus et. In hac habitasse platea dictumst. Phasellus vel facilisis nisi, et convallis erat. Vivamus ultrices tellus massa, id laoreet neque elementum vitae. Vestibulum ultrices, mauris sit amet pretium volutpat, lorem enim ornare felis, in congue lacus sem "
        label.numberOfLines = 0
        label.textColor = .white
        label.font = UIFont(name: "NanumSquareB", size: 15.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    // MARK: 각 이용약관 동의버튼
    let agreeBtn1: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .black
        btn.setImage(UIImage(named: "서비스 이용약관"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let agreeBtn2: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .clear
        btn.setImage(UIImage(named: "개인정보 처리방침"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let agreeBtn3: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .clear
        btn.setImage(UIImage(named: "마케팅 정보"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
        
    
    // MARK: 다음으로 버튼
    let nextBtnImageView2 : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "text-field")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let nextBtn2 : UIButton = {
        let btn = UIButton()
        btn.setTitle("다음으로", for: .normal)
        btn.titleLabel?.font = UIFont(name: "NanumSquareB", size: 15.0)
        btn.titleLabel?.textColor = .white
        btn.titleLabel?.textAlignment = .center
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    
    // MARK: 버튼 관련 함수
    @objc func buttonClicked(button:UIButton){
        
        print("buttonClicked")
        
        // MARK: 클릭했는데 그 전에 클릭된 것이 없다면
        if allChecked == false {
            checkBox.setImage(UIImage(named: "check-box"), for: .normal)
            checkBox2.setImage(UIImage(named: "check-box"), for: .normal)
            checkBox3.setImage(UIImage(named: "check-box"), for: .normal)
            checkBox4.setImage(UIImage(named: "check-box"), for: .normal)
            
            // MARK: 다 체크되었다는 뜻으로 true로 설정
            isChecked = true
            isChecked2 = true
            isChecked3 = true
            isChecked4 = true
            allChecked = true
            
            // MARK: true 값을 넣어준다.
            UserDefaults.standard.set(allChecked, forKey: "allcheck")
            UserDefaults.standard.set(isChecked2, forKey: "check1")
            UserDefaults.standard.set(isChecked3, forKey: "check2")
            UserDefaults.standard.set(isChecked4, forKey: "check3")
            
            nextBtnImageView2.image = UIImage(named: "highlight-btn")
            nextBtn2.titleLabel?.textColor = .systemBlue

        }
        else
        {
            checkBox.setImage(UIImage(named: "not-check-box"), for: .normal)
            checkBox2.setImage(UIImage(named: "not-check-box"), for: .normal)
            checkBox3.setImage(UIImage(named: "not-check-box"), for: .normal)
            checkBox4.setImage(UIImage(named: "not-check-box"), for: .normal)
            
            isChecked = false
            isChecked2 = false
            isChecked3 = false
            isChecked4 = false
            allChecked = false
            UserDefaults.standard.set(allChecked, forKey: "allcheck")
            UserDefaults.standard.set(isChecked2, forKey: "check1")
            UserDefaults.standard.set(isChecked3, forKey: "check2")
            UserDefaults.standard.set(isChecked4, forKey: "check3")
            nextBtnImageView2.image = UIImage(named: "text-field")
            nextBtn2.titleLabel?.textColor = .white
        }
 
    }
    
    
    @objc func buttonClicked2(button:UIButton){
        
        if isChecked2 == false{
            button.setImage(UIImage(named: "check-box"), for: .normal)
        }
        else{
            button.setImage(UIImage(named: "not-check-box"), for: .normal)
        }
        
        if isChecked2 == true{
            isChecked2 = false
            UserDefaults.standard.set(isChecked2, forKey: "check1")
            nextBtnImageView2.image = UIImage(named: "text-field")
            nextBtn2.titleLabel?.textColor = .white
        }
        else{
            isChecked2 = true
            UserDefaults.standard.set(isChecked2, forKey: "check1")
            
            // MARK: 두 번째 체크박스는 이미 눌려져있으니 논 외로, 그 외에 다 체크되었는지
            if isChecked3 == true && isChecked4 == true{
                nextBtnImageView2.image = UIImage(named: "highlight-btn")
                nextBtn2.titleLabel?.textColor = .systemBlue
            }
            else {
                nextBtnImageView2.image = UIImage(named: "text-field")
                nextBtn2.titleLabel?.textColor = .white
            }
        }
    }

    
    



    @objc func buttonClicked3(button:UIButton){
        
        if isChecked3 == false{
            button.setImage(UIImage(named: "check-box"), for: .normal)
        }
        else{
            button.setImage(UIImage(named: "not-check-box"), for: .normal)
        }
        
        if isChecked3 == true{
            isChecked3 = false
            UserDefaults.standard.set(isChecked3, forKey: "check2")
            nextBtnImageView2.image = UIImage(named: "text-field")
            nextBtn2.titleLabel?.textColor = .white
        }
        else{
            isChecked3 = true
            UserDefaults.standard.set(isChecked3, forKey: "check2")
            
            // MARK: 세 번째 체크박스는 이미 눌려져있으니 논 외로, 그 외에 다 체크되었는지
            if isChecked2 == true && isChecked4 == true{
                nextBtnImageView2.image = UIImage(named: "highlight-btn")
                nextBtn2.titleLabel?.textColor = .systemBlue
            }
            else {
                nextBtnImageView2.image = UIImage(named: "text-field")
                nextBtn2.titleLabel?.textColor = .white
            }
        }
 
    }
    
    @objc func buttonClicked4(button:UIButton){
        
        if isChecked4 == false{
            button.setImage(UIImage(named: "check-box"), for: .normal)
            //check2height.isActive = true
        }
        else{
            button.setImage(UIImage(named: "not-check-box"), for: .normal)
           // check2height.isActive = false
        }
        
        if isChecked4 == true{
            isChecked4 = false
            UserDefaults.standard.set(isChecked4, forKey: "check3")
            nextBtnImageView2.image = UIImage(named: "text-field")
            nextBtn2.titleLabel?.textColor = .white
        }
        else{
            isChecked4 = true
            UserDefaults.standard.set(isChecked4, forKey: "check3")
            
            // MARK: 네 번째 체크박스는 이미 눌려져있으니 논 외로, 그 외에 다 체크되었는지
            if isChecked2 == true && isChecked3 == true{
                nextBtnImageView2.image = UIImage(named: "highlight-btn")
                nextBtn2.titleLabel?.textColor = .systemBlue
            }
            else {
                nextBtnImageView2.image = UIImage(named: "text-field")
                nextBtn2.titleLabel?.textColor = .white
            }
            
        }
    }
    
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        addSubview(agreeLabel)
        

        addSubview(lineImageView)
        addSubview(allAgreeLabel)
        addSubview(checkBox)
        
        
        addSubview(textboxView)
        addSubview(textboxContent)

        addSubview(checkBox2)
        addSubview(checkBox3)
        addSubview(checkBox4)
        
        addSubview(agreeBtn1)
        addSubview(agreeBtn2)
        addSubview(agreeBtn3)
        
        addSubview(nextBtnImageView2)
        addSubview(nextBtn2)


        
        self.agreeLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(80)
            $0.left.equalToSuperview().offset(20)
        }
        
        
        // MARK: 모두 동의하기
        self.checkBox.snp.makeConstraints{
            $0.top.equalTo(agreeLabel.snp.bottom).offset(50)
            $0.left.equalToSuperview().offset(20)
        }
        
        self.allAgreeLabel.snp.makeConstraints{
            $0.top.equalTo(agreeLabel.snp.bottom).offset(55)
            $0.left.equalTo(checkBox.snp.right).offset(20)
        }
        
        self.lineImageView.snp.makeConstraints{
            $0.top.equalTo(checkBox.snp.bottom).offset(20)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
        }
        
        
        // MARK: 텍스트 박스
        self.textboxView.snp.makeConstraints{
            $0.top.equalTo(lineImageView.snp.bottom).offset(20)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.bottom.equalTo(nextBtnImageView2.snp.top).offset(-300)
        }
        
        self.textboxContent.snp.makeConstraints{
            $0.top.equalTo(lineImageView.snp.bottom).offset(30)
            $0.left.equalToSuperview().offset(40)
            $0.right.equalToSuperview().offset(-40)
            $0.bottom.equalTo(nextBtnImageView2.snp.top).offset(-320)
        }
        
        
        // MARK: 마케팅정보 등의 체크박스
        self.checkBox2.snp.makeConstraints{
            $0.top.equalTo(textboxView.snp.bottom).offset(30)
            $0.left.equalToSuperview().offset(20)
        }
        
        self.checkBox3.snp.makeConstraints{
            $0.top.equalTo(checkBox2.snp.bottom).offset(30)
            $0.left.equalToSuperview().offset(20)
        }
        
        self.checkBox4.snp.makeConstraints{
            $0.top.equalTo(checkBox3.snp.bottom).offset(30)
            $0.left.equalToSuperview().offset(20)
        }
        
        
        self.agreeBtn1.snp.makeConstraints{
            $0.top.equalTo(textboxView.snp.bottom).offset(35)
            $0.left.equalTo(checkBox2.snp.right).offset(20)
        }
        
        self.agreeBtn2.snp.makeConstraints{
            $0.top.equalTo(checkBox2.snp.bottom).offset(35)
            $0.left.equalTo(checkBox3.snp.right).offset(20)
        }
        
        self.agreeBtn3.snp.makeConstraints{
            $0.top.equalTo(checkBox3.snp.bottom).offset(35)
            $0.left.equalTo(checkBox4.snp.right).offset(20)
        }
        
        // MARK: 다음으로 버튼
        self.nextBtnImageView2.snp.makeConstraints{
            $0.bottom.equalToSuperview().offset(-10)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
        }
        
        
        self.nextBtn2.snp.makeConstraints{
            $0.top.equalTo(nextBtnImageView2).offset(10)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            
        }


        
    }
    
    
    required init?(coder: NSCoder){
        fatalError("init?(coder:) is not Supported")
    }
    
}
