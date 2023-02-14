//
//  RegisterationController.swift
//  LGHTSG
//
//  Created by HA on 2023/01/09.
//

import UIKit
import Alamofire

class RegisterationController: UIViewController {
    
    
    
    // MARK: 네비게이션 바 생성
    let navigationBar2 : UINavigationBar = {
        let navigationBar = UINavigationBar()
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        return navigationBar
    }()
    
    let registerLabel : UILabel = {
        let label = UILabel()
        label.text = "똑똑한 투자를 시작해보세요!"
        label.textColor = .systemBlue
        label.font = UIFont(name: "NanumSquareEB", size: 20.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let registerLabel2 : UILabel = {
        let label = UILabel()
        label.text = ", 저희와 함께"
        label.textColor = .white
        label.font = UIFont(name: "NanumSquareEB", size: 20.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let iconImageView : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "icon")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
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
    
    let codeSuccessLabel: UILabel = {
        let label = UILabel()
        label.text = "⎷ 이메일 인증이 완료되었습니다."
        label.font = UIFont(name: "NanumSquareR", size: 12.0)
        label.textColor = .systemGreen
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
    
    
    
    
    var profileImageView : UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = image.frame.height/2
        image.layer.borderWidth = 1
        image.layer.masksToBounds = true
        image.contentMode = .scaleToFill
        image.layer.borderColor = UIColor.clear.cgColor // 원형 이미지의 테두리 제거
        image.clipsToBounds = true
        image.image = UIImage(named: "profile")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
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
            codeConfirmSuccessheight.isActive = false
            codeConfirmheight2.isActive = true
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
    var codeConfirmSuccessheight: NSLayoutConstraint!

    
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
        
        codeConfirmSuccessheight = codeSuccessLabel.heightAnchor.constraint(equalToConstant: 0)
        codeConfirmSuccessheight.isActive = true
    }
    
    
    
    @objc func tapDismissButton(){
        self.presentingViewController?.dismiss(animated: true)
        UserDefaults.standard.removeObject(forKey: "allcheck")
        UserDefaults.standard.removeObject(forKey: "check1")
        UserDefaults.standard.removeObject(forKey: "check2")
        UserDefaults.standard.removeObject(forKey: "check3")
    }
    
    
    // 키보드때문에 화면이 가려질 경우 화면을 올린다
    @objc func keyboardWillShow(sender: NSNotification) {
        self.view.frame.origin.y = -180 // Move view 150 points upward
    }
    
    @objc func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y = 0 // Move view to original position
    }
    
    func tapImage(imageView: UIImageView){
        var tap = UITapGestureRecognizer()
        if imageView == profileImageView {
            print("프로필 설정")
            tap = UITapGestureRecognizer(target: self, action: #selector(changeProfile))
        }
        imageView.addGestureRecognizer(tap)
        imageView.isUserInteractionEnabled = true
    }
    
    // MARK: 프로필 설정
    @objc func changeProfile(){
        profileImagePicker.sourceType = .photoLibrary
        profileImagePicker.allowsEditing = false
        profileImagePicker.delegate = self
        present(profileImagePicker, animated: true)
    }
    
    
    
    let joinAccess = JoinApiModel()
    var userIndex : Int!
    
    @objc func joinBtnClicked2(){
        
        let RegisterView = RegisterView()
        
        var confirmCheck = UserDefaults.standard.bool(forKey: "ConfirmSuccess") ?? false
        var samePw = UserDefaults.standard.bool(forKey: "samePw") ?? false
        var validPw = UserDefaults.standard.bool(forKey: "validPw") ?? false
        
        
        print(confirmCheck)
        print(samePw)
        print(validPw)
        
        if confirmCheck == true && samePw == true && validPw == true {
            print("회원가입 가능!")
            let userName = nameTextField.text
            let email = emailTextField3.text
            let password = passwordTextField3.text
            let emailCheck = "1"
            let profileImg = "urlurl"
            
            print(userName, email, password)
            
            let bodyData : Parameters = [
                "userName" : userName,
                "email" : email,
                "password" : password,
                "emailCheck" : emailCheck,
                //"profileImg" : profileImg
            ]
            joinAccess.requestJoinDataModel(bodyData: bodyData){
                data in
                print(data.body)
            }
            
            self.present(RegisterationSuccessController(), animated: true)
        }
        else{
            print("회원가입 불가능")
        }
    }
    
    
    
    @objc func nextBtnClicked(){
        let success = UserDefaults.standard.bool(forKey: "success")
        if success == true {
            print("회원가입완료")
            self.present(RegisterationSuccessController(), animated: true)
            UserDefaults.standard.removeObject(forKey: "success")
        }
        else {
            print("아직 회원가입 안됨")
        }
    }
    
    
    // MARK: https://mansu.tistory.com/120
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        heightSetting2()
        
        view.backgroundColor = .black
        view.addSubview(iconImageView)
        view.addSubview(registerLabel)
        view.addSubview(registerLabel2)
        //view.addSubview(profileImageView)
        view.addSubview(nameImageView)
        view.addSubview(nameTextField)
        
        view.addSubview(emailSendImageView2)
        view.addSubview(emailTextField3)
        view.addSubview(emailCodeBtn2)
        view.addSubview(codeSendLabel2)
        
        view.addSubview(codeSendImageView2)
        view.addSubview(codeTextField2)
        view.addSubview(codeConfirmBtn2)
        view.addSubview(codeConfirmLabel2)
        view.addSubview(codeSuccessLabel)
        
        
        view.addSubview(pwImageView2)
        view.addSubview(passwordTextField3)
        view.addSubview(pwValidLabel2)
        
        view.addSubview(pwImageCheckView2)
        view.addSubview(passworCheckdTextField3)
        view.addSubview(pwSameLabel2)
        
        
        view.addSubview(nextBtnImageView)
        view.addSubview(nextBtn)
        
        
        // MARK: 이름 설정 위치
        self.iconImageView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(80)
            $0.left.equalToSuperview().offset(20)
        }
        
        self.registerLabel2.snp.makeConstraints{
            $0.top.equalToSuperview().offset(80)
            $0.left.equalTo(iconImageView.snp.right).offset(5)
        }
        
        // MARK: 이름 설정 위치
        self.registerLabel.snp.makeConstraints{
            $0.top.equalTo(iconImageView.snp.bottom).offset(20)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
        }
        
        
        // MARK: 이름 설정 위치
        self.nameImageView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(200)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
        }
        
        self.nameTextField.snp.makeConstraints{
            $0.top.equalToSuperview().offset(215)
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
        
        self.codeSuccessLabel.snp.makeConstraints{
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
            $0.top.equalTo(nextBtnImageView.snp.top).offset(10)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
        }
            
            
            
            /*
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(changeProfile))
            profileImageView.addGestureRecognizer(tap)
            profileImageView.isUserInteractionEnabled = true
            
            
            
            // MARK: profile 위치 설정
            self.profileImageView.snp.makeConstraints{
                $0.top.equalToSuperview().offset(120)
                $0.centerX.equalToSuperview()
            }
            
            profileImageView.snp.makeConstraints { make in
                make.height.equalTo(100)
                make.width.equalTo(100)
            }
            
            */
            
            
            // MARK: 키보드 올라갔을 때 화면 터치해서 내려가게함
            let tapGesture = UITapGestureRecognizer(target: self.view, action: #selector(self.view.endEditing(_:)))
            self.view.addGestureRecognizer(tapGesture)
            // MARK: 키보드가 화면을 가릴 때 화면을 위로 올릴 수 있도록
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil);
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil);
            
            
            // MARK: 네비게이션 컨트롤러
            self.view.addSubview(navigationBar2)
            let safeArea = self.view.safeAreaLayoutGuide
            let navigationAppearance = UINavigationBarAppearance()
            
            navigationAppearance.backgroundColor = .black
            navigationAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            navigationBar2.tintColor = UIColor.white
            navigationBar2.standardAppearance = navigationAppearance
            navigationBar2.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            navigationBar2.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
            navigationBar2.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
            
            let navItem = UINavigationItem(title: "회원가입")
            let leftButton = UIBarButtonItem(image: UIImage(named: "back-arrow"), style: .plain, target: self, action: #selector(tapDismissButton))
            
            navItem.leftBarButtonItem = leftButton
            
            navigationBar2.setItems([navItem], animated: true)
            
            
            // MARK: 화면 전환이나 실행함수
            nextBtn.addTarget(self, action: #selector(joinBtnClicked2), for: .touchUpInside)
        }
        
    
    
}


extension RegisterationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
            
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
                
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.profileImageView.image = image
            self.profileImageView.layer.cornerRadius = profileImageView.frame.height/2
            self.profileImageView.contentMode = .scaleToFill
            self.profileImageView.clipsToBounds = true
            self.profileImageView.layer.borderColor = UIColor.black.cgColor // 원형 이미지의 테두리 제거
                /*
                     // 고유한 이미지 이름을 위해 타임스템프 값을 활용
                     let timestamp: Int = icuDateToSeconds(getNow())
                     // 사용자이름_타임스템프.jpg 형식으로 파일이름 지정
                     let imageFileName: String = userName + "_" + String(timestamp) + ".jpg"
                     // 이미지가 저장될 경로
                     let imageFilePath: String = imageDirectory.path + imageFileName
                     */
                }
                dismiss(animated: true, completion: nil)
                
            }
        
    }
