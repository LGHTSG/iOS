//
//  RegisterView.swift
//  LGHTSG
//
//  Created by 홍수정 on 2023/01/25.
//

import Foundation
import UIKit
import Alamofire
import SnapKit

class RegisterView : UIView {
    
    // MARK: 네비게이션 바 생성
    let navigationBar2 : UINavigationBar = {
        let navigationBar = UINavigationBar()
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        return navigationBar
    }()
    
    var profileImageData : String!
    
    // MARK: imagePicker
    var profileImagePicker = UIImagePickerController()

    
    // MARK: 사용자 이름
    let nameImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "text-field")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    // hell@world.com, test1234!
    
    let nameTextField: UITextField = {
        let name = UITextField()
        name.leftViewMode = .always
        name.attributedPlaceholder = NSAttributedString(string: "이름", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        name.borderStyle = .none
        name.textColor = .white // 글자색을 흰색으로
        name.font = UIFont(name: "NanumSquareB", size: 15.0)
        name.enablesReturnKeyAutomatically = true
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    // MARK: 이메일 인증번호 보내기
    let emailSendImageView2: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "send-code-btn")
        return image
    }()
    
    let emailTextField3: UITextField = {
        let label = UITextField()
        label.attributedPlaceholder = NSAttributedString(string: "이메일", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        label.leftViewMode = .always
        label.keyboardType = .emailAddress
        label.textColor = .white
        label.font = UIFont(name: "NanumSquareB", size: 15.0)
        label.borderStyle = .none
        label.enablesReturnKeyAutomatically = true
        return label
    }()
    
    let emailCodeBtn2: UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont(name: "NanumSquareB", size: 12.0)
        btn.addTarget(self, action: #selector(emailCodeBtnClicked2), for: .touchUpInside)
       //btn.backgroundColor = .red
        btn.layer.cornerRadius = 5
        return btn
    }()
    
    
    // MARK: 인증번호 발송 메세지
    let codeSendLabel2: UILabel = {
        let label = UILabel()
        label.text = "인증번호가 발송되었습니다"
        label.font = UIFont(name: "NanumSquareR", size: 12.0)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    // MARK: 인증번호 확인하기
    let codeTextField2: UITextField = {
        let label = UITextField()
        label.attributedPlaceholder = NSAttributedString(string: "인증번호", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        label.leftViewMode = .always
        label.textColor = .white
        label.font = UIFont(name: "NanumSquareB", size: 15.0)
        label.borderStyle = .none
        label.enablesReturnKeyAutomatically = true
        label.keyboardType = .numberPad
        return label
    }()
    
    let codeSendImageView2: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "confirm-code-btn")
        return image
    }()
    
    
    let codeConfirmBtn2: UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont(name: "NanumSquareB", size: 12.0)
        //btn.backgroundColor = .blue
        btn.addTarget(self, action: #selector(codeConfirmBtnClicked2), for: .touchUpInside)
        btn.layer.cornerRadius = 5
        return btn
    }()
    
    
    let codeConfirmLabel2: UILabel = {
        let label = UILabel()
        label.text = "인증번호가 일치하지 않습니다."
        label.font = UIFont(name: "NanumSquareR", size: 12.0)
        label.textColor = .systemRed
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    // MARK: 비밀번호
    let pwImageView2: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "text-field")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let passwordTextField3: UITextField = {
        let name = UITextField()
        name.leftViewMode = .always
        name.attributedPlaceholder = NSAttributedString(string: "비밀번호", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        name.borderStyle = .none
        name.textColor = .white // 글자색을 흰색으로
        name.isSecureTextEntry = true
        name.font = UIFont(name: "NanumSquareB", size: 15.0)
        name.addTarget(self, action: #selector(pwFieldEdited2), for: UIControl.Event.editingChanged)
        name.enablesReturnKeyAutomatically = true
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    let pwValidLabel2: UILabel = {
        let label = UILabel()
        label.text = "영문, 숫자, 특수문자를 포함한 7자 이상으로 입력해주세요."
        label.font = UIFont(name: "NanumSquareR", size: 12.0)
        label.textColor = .systemRed
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: 비밀번호 찾기
    let pwImageCheckView2: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "text-field")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let passworCheckdTextField3: UITextField = {
        let name = UITextField()
        name.leftViewMode = .always
        name.attributedPlaceholder = NSAttributedString(string: "비밀번호 확인", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        name.borderStyle = .none
        name.textColor = .white // 글자색을 흰색으로
        name.isSecureTextEntry = true
        name.font = UIFont(name: "NanumSquareB", size: 15.0)
        name.addTarget(self, action: #selector(pwFieldEdited2), for: UIControl.Event.editingChanged)
        name.enablesReturnKeyAutomatically = true
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    let pwSameLabel2: UILabel = {
        let label = UILabel()
        label.text = "비밀번호가 일치하지 않습니다."
        label.font = UIFont(name: "NanumSquareR", size: 12.0)
        label.textColor = .systemRed
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        
    let nextBtnImageView : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "text-field")
        return image
    }()
    
    let nextBtn : UIButton = {
        let label = UIButton()
        label.setTitle("다음으로", for: .normal)
        label.titleLabel?.font = UIFont(name: "NanumSquareB", size: 15.0)
        label.titleLabel?.textColor = .white
        label.titleLabel?.textAlignment = .center
        //label.addTarget(self, action: #selector(joinBtnClicked2), for: .touchUpInside)
        return label
    }()
    

    
    let emailCode2 = emailApiModel()
    var code : String = "dklsfjkljdlvnmnxlmnszlksjwr091u3tghjkfnm,gdsajlkfjsclxnm,zbghjkjilekdsfkhglksefmdfbjfo;gsdlfknjbldkgs"
    
    // MARK: 인증번호 발송 함수
    @objc func emailCodeBtnClicked2(){
        print("인증번호 발송버튼")
        guard let email = emailTextField3.text else {return}
        
        let bodyData : Parameters = [
            "email" : email,
        ]
        
        emailCode2.requestEmailDataModel(bodyData: bodyData){
            data in
            self.code = data.body
            print(self.code)
        }
        sendCodeheight2.isActive = false
    }
    
    
    // MARK: 인증번호 확인 함수
    @objc func codeConfirmBtnClicked2(){
        if codeTextField2.text == self.code {
            print("번호같음")
            emailTextField3.isUserInteractionEnabled = false
            codeTextField2.isUserInteractionEnabled = false
            codeConfirmheight2.isActive = true
            emailSuccess = "1"
            UserDefaults.standard.set(true, forKey: "ConfirmSuccess")
        }
        else {
            codeConfirmheight2.isActive = false
        }
    }
    
    var validPw : String = "dlfksjd"
    var samePw : String = "slkfjlkdjflk"
    var emailSuccess : String = "dlskjflksjq3oi39hs"
    
    // MARK: 패스워드 맞는지 확인하는 함수
    func isSamePassword2(_ first: UITextField, _ second: UITextField) -> Bool {
        if (first.text == second.text){
            samePw = "1"
            UserDefaults.standard.set(true, forKey: "samePw")
            return true
        }
        return false
    }
    
    // MARK: 패스워드 유효한지 확인 함수
    func isValidPassword2(pw: String?) -> Bool{
        
        let regex = "^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[!@#$%^&*()_+=-]).{8,50}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        
           if let hasPassword = pw{
               // 길이 확인
               if hasPassword.count > 7  && predicate.evaluate(with: hasPassword){
                   print("패스워드 유효")
                   validPw = "1"
                   UserDefaults.standard.set(true, forKey: "validPw")
                   return true
               }
           }
           return false
       }
    
    
    var isCheck3 : Bool = false
    var isCheck4 : Bool = false

    // MARK: 패스워드의 결과에 따라 메세지를 보여줄지 여부를 정하는 코드
    @objc func pwFieldEdited2(textField: UITextField) {
        
        if textField == passwordTextField3 {
            if isValidPassword2(pw: passwordTextField3.text)
            {
                print("유효함")
                pwheight3.isActive = true
                isCheck3 = true
            }
            else{
                print("유효하지않음")
                pwheight3.isActive = false
                isCheck3 = false

            }
        }
        
        else if textField == passworCheckdTextField3 {
            if isSamePassword2(passwordTextField3, passworCheckdTextField3)
            {
                print("같음")
                pwheight4.isActive = true
                isCheck4 = true
            }
            else{
                print("다름")
                pwheight4.isActive = false
                isCheck4 = false
            }
        }
    }
    
    // MARK: 인증번호 관련 동적 변화 라벨
    var sendCodeheight2: NSLayoutConstraint!
    var codeConfirmheight2: NSLayoutConstraint!

    // MARK: 비밀번호에 따른 메세지
    var pwheight3: NSLayoutConstraint!
    var pwheight4: NSLayoutConstraint!
    
    func heightSetting2(){
        
        sendCodeheight2 = codeSendLabel2.heightAnchor.constraint(equalToConstant: 0)
        sendCodeheight2.isActive = true
        
        codeConfirmheight2 = codeConfirmLabel2.heightAnchor.constraint(equalToConstant: 0)
        codeConfirmheight2.isActive = true
        
        pwheight3 = pwValidLabel2.heightAnchor.constraint(equalToConstant: 0)
        pwheight3.isActive = true
        
        pwheight4 = pwSameLabel2.heightAnchor.constraint(equalToConstant: 0)
        pwheight4.isActive = true

    }
    
    /*
    let joinAccess = JoinApiModel()
    var userIndex : Int!
    
    @objc func joinBtnClicked2(){
        
        if validPw == "1" && samePw == "1"{
            if emailSuccess == "1" {
                print("회원가입 가능!")
                guard let userName = nameTextField.text else {return}
                guard let email = emailTextField3.text else {return}
                guard let password = passwordTextField3.text else {return}
                let emailCheck = "1"
                let profileImg = "urlurl"
                
                let bodyData : Parameters = [
                    "userName" : userName,
                    "email" : email,
                    "password" : password,
                    "emailCheck" : emailCheck,
                    "profileImg" : profileImg
                ]

                joinAccess.requestJoinDataModel(bodyData: bodyData){
                    data in
                    print(data.body)
                }
                UserDefaults.standard.set(true, forKey: "joinSuccess")
            }
            else {
                print("인증번호 비완료")
            }
        }
        else{
            print("비밀번호 과정을 통과하지못해 회원가입 불가능")
        }
    }
     */
    
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)

        heightSetting2()

        addSubview(nameImageView)
        addSubview(nameTextField)
        
        addSubview(emailSendImageView2)
        addSubview(emailTextField3)
        addSubview(emailCodeBtn2)
        addSubview(codeSendLabel2)

        addSubview(codeSendImageView2)
        addSubview(codeTextField2)
        addSubview(codeConfirmBtn2)
        addSubview(codeConfirmLabel2)
        
        
        addSubview(pwImageView2)
        addSubview(passwordTextField3)
        addSubview(pwValidLabel2)
        
        addSubview(pwImageCheckView2)
        addSubview(passworCheckdTextField3)
        addSubview(pwSameLabel2)
        
        
        addSubview(nextBtnImageView)
        addSubview(nextBtn)
        

        
        // MARK: 이름 설정 위치
        self.nameImageView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(40)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
        }
        
        self.nameTextField.snp.makeConstraints{
            $0.top.equalToSuperview().offset(55)
            $0.left.equalToSuperview().offset(30)
            $0.right.equalToSuperview().offset(-20)
        }
        
        // MARK: 이메일 작성 및 전송 버튼 위치
        self.emailSendImageView2.snp.makeConstraints{
            $0.top.equalTo(nameImageView.snp.bottom).offset(30)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
        }
        
        self.emailTextField3.snp.makeConstraints{
            $0.top.equalTo(nameImageView.snp.bottom).offset(45)
            $0.left.equalToSuperview().offset(30)
            $0.right.equalToSuperview().offset(-120)
        }
        
        self.emailCodeBtn2.snp.makeConstraints{
            $0.top.equalTo(nameImageView.snp.bottom).offset(30)
            $0.left.equalTo(emailTextField3.snp.right).offset(10)
            $0.right.equalTo(emailSendImageView2.snp.right).offset(0)
            $0.height.equalTo(emailSendImageView2).offset(0)
        }
        
        
        // MARK: 인증번호 작성 및 확인 버튼 위치
        self.codeSendImageView2.snp.makeConstraints{
            $0.top.equalTo(emailSendImageView2.snp.bottom).offset(30)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
        }
        
        self.codeSendLabel2.snp.makeConstraints{
            $0.top.equalTo(emailSendImageView2.snp.bottom).offset(5)
            $0.left.equalTo(emailSendImageView2.snp.left)
        }
        
        self.codeTextField2.snp.makeConstraints{
            $0.top.equalTo(emailSendImageView2.snp.bottom).offset(45)
            $0.left.equalToSuperview().offset(30)
            $0.right.equalToSuperview().offset(-120)
        }
        
        self.codeConfirmBtn2.snp.makeConstraints{
            $0.top.equalTo(codeSendImageView2.snp.top).offset(0)
            $0.left.equalTo(codeTextField2.snp.right).offset(10)
            $0.right.equalTo(codeSendImageView2.snp.right).offset(0)
            $0.height.equalTo(codeSendImageView2.snp.height).offset(0)
        }
        
        self.codeConfirmLabel2.snp.makeConstraints{
            $0.top.equalTo(codeSendImageView2.snp.bottom).offset(5)
            $0.left.equalTo(codeSendImageView2.snp.left)
        }
        
        
        // MARK: 비밀번호 설정 위치
        self.pwImageView2.snp.makeConstraints{
            $0.top.equalTo(codeConfirmBtn2.snp.bottom).offset(30)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
        }
        
        self.passwordTextField3.snp.makeConstraints{
            $0.top.equalTo(codeConfirmBtn2.snp.bottom).offset(45)
            $0.left.equalToSuperview().offset(30)
            $0.right.equalToSuperview().offset(-20)
        }
        
        self.pwValidLabel2.snp.makeConstraints{
            $0.top.equalTo(pwImageView2.snp.bottom).offset(5)
            $0.left.equalTo(pwImageView2.snp.left)
        }
        
        self.pwImageCheckView2.snp.makeConstraints{
            $0.top.equalTo(pwImageView2.snp.bottom).offset(30)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
        }
        
        self.passworCheckdTextField3.snp.makeConstraints{
            $0.top.equalTo(pwImageView2.snp.bottom).offset(45)
            $0.left.equalToSuperview().offset(30)
            $0.right.equalToSuperview().offset(-20)
        }
        
        self.pwSameLabel2.snp.makeConstraints{
            $0.top.equalTo(pwImageCheckView2.snp.bottom).offset(5)
            $0.left.equalTo(pwImageCheckView2.snp.left)
        }

        // MARK: 다음으로 버튼
        self.nextBtnImageView.snp.makeConstraints{
            $0.bottom.equalToSuperview().offset(-10)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
        }
        
        self.nextBtn.snp.makeConstraints{
            $0.top.equalTo(nextBtnImageView).offset(10)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            
        }
        
        
    }
    
    required init?(coder: NSCoder){
        fatalError("init?(coder:) is not Supported")
    }
}

