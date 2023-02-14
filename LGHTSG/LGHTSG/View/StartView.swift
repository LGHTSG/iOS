

import Foundation
import UIKit
import SnapKit
import Alamofire

class StartView: UIView {
    
    let titleImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "icon")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let loginBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "login-btn"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    
    let joinBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("회원가입", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont(name: "NanumSquareR", size: 12.0)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let findPwBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("비밀번호 변경", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont(name: "NanumSquareR", size: 12.0)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let middleLabel: UILabel = {
        let label = UILabel()
        label.text = "|"
        label.font = UIFont(name: "NanumSquareR", size: 12.0)
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let kakaoLoginline: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "login-line")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    
    // MARK: 카카오 로그인 버튼 생성
    let kakaoLoginBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "kakaoLogin"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleImageView)
        
        addSubview(loginBtn)
        
        addSubview(joinBtn)
        addSubview(middleLabel)
        addSubview(findPwBtn)
        
        //addSubview(kakaoLoginline)
        //addSubview(kakaoLoginBtn)

        
        // MARK: 맨 위 이미지 위치
        self.titleImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(280)
            $0.centerX.equalToSuperview()
        }


        
        // MARK: 로그인 버튼
        self.loginBtn.snp.makeConstraints {
            $0.top.equalTo(titleImageView.snp.bottom).offset(50)
            $0.centerX.equalToSuperview()
            $0.left.equalToSuperview().offset(30)
            $0.right.equalToSuperview().offset(-30)
        }
        
        
        // MARK: 회원가입 및 비밀번호 찾기
        self.middleLabel.snp.makeConstraints{
            $0.top.equalTo(loginBtn.snp.bottom).offset(15)
            $0.centerX.equalTo(loginBtn)
        }
        
        self.joinBtn.snp.makeConstraints{
            $0.top.equalTo(loginBtn.snp.bottom).offset(8)
            $0.right.equalTo(middleLabel.snp.left).offset(-20)
        }
        
        
        self.findPwBtn.snp.makeConstraints{
            $0.top.equalTo(loginBtn.snp.bottom).offset(8)
            $0.left.equalTo(middleLabel.snp.right).offset(20)
        }
        
        /*
        // MARK: 카카오 로그인 버튼 및 라인 위치
        self.kakaoLoginline.snp.makeConstraints{
            $0.top.equalTo(joinBtn.snp.bottom).offset(180)
            $0.centerX.equalToSuperview()
            $0.left.equalToSuperview().offset(30)
            $0.right.equalToSuperview().offset(-30)
        }
        
        self.kakaoLoginBtn.snp.makeConstraints{
            $0.top.equalTo(kakaoLoginline.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.left.equalToSuperview().offset(30)
            $0.right.equalToSuperview().offset(-30)
        }*/
        
        
        
    }
    
    required init?(coder: NSCoder){
        fatalError("init?(coder:) is not Supported")
    }
    
}
