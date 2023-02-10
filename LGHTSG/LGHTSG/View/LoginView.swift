//
//  LoginView.swift
//  LGHTSG
//
//  Created by 홍수정 on 2023/01/25.
//

import Foundation
import UIKit
import SnapKit
import Alamofire

class LoginView: UIViewController {
    
    let titleImageView2: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "icon")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let privacyPolicyLabel: UILabel = {
        let label = UILabel()
        label.text = "개인정보처리방침"
        label.textColor = .white
        label.font = UIFont(name: "NanumSquareB", size: 13.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let memberInquiryLabel: UILabel = {
        let label = UILabel()
        label.text = "회원 정보 문의 : admin@rghtsg.com"
        label.textColor = .lightGray
        label.font = UIFont(name: "NanumSquareR", size: 12.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let emailTextField: UITextField = {
        let email = UITextField()
        email.layer.cornerRadius = 5
        email.leftViewMode = .always
        email.attributedPlaceholder = NSAttributedString(string: "이메일", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        email.textColor = .white
        email.font = UIFont(name: "NanumSquareR", size: 15.0)
        email.borderStyle = .none
        email.enablesReturnKeyAutomatically = true
        email.translatesAutoresizingMaskIntoConstraints = false
        return email
    }()
    
    
    let passwordTextField: UITextField = {
        let password = UITextField()
        password.layer.cornerRadius = 5
        password.leftViewMode = .always
        password.attributedPlaceholder = NSAttributedString(string: "비밀번호", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        password.borderStyle = .none
        password.textColor = .white // 글자색을 흰색으로
        password.isSecureTextEntry = true
        password.font = UIFont(name: "NanumSquareR", size: 15.0)
        password.translatesAutoresizingMaskIntoConstraints = false
        return password
    }()
    
    let emailImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "text-field")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let pwImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "text-field")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let loginBtn2: UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(named: "login-btn2"), for: .normal)
        //btn.addTarget(self, action: #selector(loginBtnClicked2), for: .touchUpInside)
        btn.addTarget(self, action: #selector(loginBtnClicked), for: .touchUpInside)

        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    let joinBtn2: UIButton = {
        let btn = UIButton()
        btn.setTitle("회원가입", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont(name: "NanumSquareR", size: 12.0)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    
    let findPwBtn2: UIButton = {
        let btn = UIButton()
        btn.setTitle("비밀번호 찾기", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont(name: "NanumSquareR", size: 12.0)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let middleLabel2: UILabel = {
        let label = UILabel()
        label.text = "|"
        label.font = UIFont(name: "NanumSquareR", size: 12.0)
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let loginWrongLabel: UILabel = {
        let label = UILabel()
        label.text = "없는 아이디거나 비밀번호가 틀렸습니다."
        label.font = UIFont(name: "NanumSquareR", size: 12.0)
        label.textColor = .systemRed
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let login = LoginApiModel()
    let loginMsgCode = LoginApiHeaderModel()
    var jwt : String = ""
    var msgCode : Int = 0
    var result = LoginResult(jwt: "")
    
    @objc func loginBtnClicked(){
        
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        

        let bodyData : Parameters = [
            "email" : email,
            "password" : password
        ]
                
        login.requestLoginDataModel(bodyData: bodyData){
            data in
//            self.jwt = data.accessToken
     //       print(data)
        }
        
        /*
        loginMsgCode.requestLoginDataModel(bodyData: bodyData){
            data in
            print(data)
        }
        */
        
        var loginSuccess = UserDefaults.standard.bool(forKey: "loginSuccess")
        loginSuccess = UserDefaults.standard.bool(forKey: "loginSuccess")
        print(loginSuccess)
        
        
        if jwt == "" {
            print("로그인안됨")
            loginWrongheight.isActive = false
        }
        else {
            loginWrongheight.isActive = true
        }

        //UserDefaults.standard.set(emailTextField.text, forKey: "id")
        //UserDefaults.standard.set(passwordTextField.text, forKey: "pw")
        

    }
    
    
    // MARK: 로그인 관련 동적라벨
    var loginWrongheight: NSLayoutConstraint!
    

    
    

    override func viewDidLoad() {
        
        loginWrongheight = loginWrongLabel.heightAnchor.constraint(equalToConstant: 0)
        loginWrongheight.isActive = true
        
        view.addSubview(titleImageView2)
        
        view.addSubview(emailImageView)
        view.addSubview(emailTextField)
        
        view.addSubview(pwImageView)
        view.addSubview(passwordTextField)
        view.addSubview(loginWrongLabel)
        
        view.addSubview(loginBtn2)
        view.addSubview(joinBtn2)
        view.addSubview(middleLabel2)
        view.addSubview(findPwBtn2)

        
        //view.addSubview(pwChangeBtn)
        //view.addSubview(middleLabel)
        //view.addSubview(joinBtn)
        
        //view.addSubview(errorEmailLabel)
        //view.addSubview(errorPwLabel)
        
        view.addSubview(privacyPolicyLabel)
        view.addSubview(memberInquiryLabel)
        
        
        // MARK: 맨 위 이미지 위치
        self.titleImageView2.snp.makeConstraints {
            $0.top.equalToSuperview().offset(170)
            $0.centerX.equalToSuperview()
        }
        
        self.emailImageView.snp.makeConstraints {
            $0.top.equalTo(titleImageView2.snp.bottom).offset(100)
            $0.left.equalToSuperview().offset(30)
            $0.right.equalToSuperview().offset(-30)
        }
        
        self.emailTextField.snp.makeConstraints {
            $0.top.equalTo(titleImageView2.snp.bottom).offset(115)
            $0.left.equalToSuperview().offset(50)
            $0.right.equalToSuperview().offset(-30)
        }
        
        

        // MARK: 비밀번호 위치 및 배경
        // 나중에 에러 메세지 위치랑 고려해서 바꿔야함
        self.pwImageView.snp.makeConstraints {
            $0.top.equalTo(emailImageView.snp.bottom).offset(20)
            $0.left.equalToSuperview().offset(30)
            $0.right.equalToSuperview().offset(-30)
        }
        
        self.passwordTextField.snp.makeConstraints {
            $0.top.equalTo(emailImageView.snp.bottom).offset(35)
            $0.left.equalToSuperview().offset(50)
            $0.right.equalToSuperview().offset(-30)
        }
        
        self.loginWrongLabel.snp.makeConstraints{
            $0.top.equalTo(pwImageView.snp.bottom).offset(5)
            $0.left.equalToSuperview().offset(30)
            $0.right.equalToSuperview().offset(-30)
        }
        
        
        // MARK: 로그인 버튼
        self.loginBtn2.snp.makeConstraints {
            $0.top.equalTo(pwImageView.snp.bottom).offset(40)
            $0.left.equalToSuperview().offset(30)
            $0.right.equalToSuperview().offset(-30)
        }

        
        // MARK: 회원가입 및 비밀번호 찾기
        self.middleLabel2.snp.makeConstraints{
            $0.top.equalTo(loginBtn2.snp.bottom).offset(25)
            $0.centerX.equalTo(loginBtn2)
        }
        
        self.joinBtn2.snp.makeConstraints{
            $0.top.equalTo(loginBtn2.snp.bottom).offset(20)
            $0.right.equalTo(middleLabel2.snp.left).offset(-20)
        }
        
        
        self.findPwBtn2.snp.makeConstraints{
            $0.top.equalTo(loginBtn2.snp.bottom).offset(20)
            $0.left.equalTo(middleLabel2.snp.right).offset(20)
        }
                
        
        // MARK: 맨 밑 글자 위치
        self.memberInquiryLabel.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(privacyPolicyLabel.snp.bottom).offset(5)
        }
        
        self.privacyPolicyLabel.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-100)
            
        }
        
        
    }
    
    required init?(coder: NSCoder){
        fatalError("init?(coder:) is not Supported")
    }
    
}
