//
//  LoginController.swift
//  LGHTSG
//
//  Created by HA on 2023/01/09.
//

import UIKit
import SnapKit
import Alamofire


// MARK: 비번 저장

class LoginController: UIViewController {
    
    
    
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
    
    
    let memberInquiryLabel: UIButton = {
        let label = UIButton()
        label.setTitle("회원 정보 문의 : admin@rghtsg.com", for: .normal)
        label.setTitleColor(.lightGray, for: .normal)
        label.titleLabel?.font = UIFont(name: "NanumSquareR", size: 12.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.addTarget(self, action: #selector(memberInquiryLabelClicked), for: .touchUpInside)
        return label
    }()
    
    @objc func memberInquiryLabelClicked(){
        print("클릭")
        if let url = URL(string: "http://lghtsh.site:8090/qna") {
                    UIApplication.shared.open(url, options: [:])
                }
    }
    
    
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
            self.jwt = data.accessToken
            UserDefaults.standard.set(data.accessToken,forKey: "savedToken")
            UserDefaults.standard.set(password,forKey: "pastPassword")
            let vc = MainTabController()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }
        
        
        var jwt : String = UserDefaults.standard.string(forKey: "savedToken") ?? ""
        print("토큰은 \(jwt)")
        
        
        if jwt == "" {
            print("로그인안됨")
            loginWrongheight.isActive = false
        }
        else {
            loginWrongheight.isActive = true

        }
        

    }
    
    
    // MARK: 로그인 관련 동적라벨
    var loginWrongheight: NSLayoutConstraint!
    
    
    func setAutoLayout(){
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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setAutoLayout()

        // MARK: 옆으로 넘기면 뒤로 갈 수 있게
        let swipeleft = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(infoviewSwipeLeft))
        swipeleft.edges = .left
        swipeleft.delegate = self
        self.view.addGestureRecognizer(swipeleft)

        
        // MARK: 화면 이동을 위한 addTarget
        findPwBtn2.addTarget(self, action: #selector(findPwClicked), for: .touchUpInside)
        joinBtn2.addTarget(self, action: #selector(joinBtnClicked), for: .touchUpInside)
        
        // MARK: 키보드 올라갔을 때 화면 터치해서 내려가게함
        let tapGesture = UITapGestureRecognizer(target: self.view, action: #selector(self.view.endEditing(_:)))
        tapGesture.delegate = self
        self.view.addGestureRecognizer(tapGesture)
        
        
        // MARK: 키보드가 화면을 가릴 때 화면을 위로 올릴 수 있도록
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil);
    }

    
    @objc func infoviewSwipeLeft(){
        self.presentingViewController?.dismiss(animated: true)
    }
    
    @objc func findPwClicked(){
        let vc = FindPassWordController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    @objc func joinBtnClicked(){
        let vc = CheckAgreeController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    // 키보드때문에 화면이 가려질 경우 화면을 올린다
    @objc func keyboardWillShow(sender: NSNotification) {
         self.view.frame.origin.y = -100 // Move view 150 points upward
    }

    @objc func keyboardWillHide(sender: NSNotification) {
         self.view.frame.origin.y = 0 // Move view to original position
    }
}


// 제스처 여러개 인식될 수 있도록
extension LoginController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
}
