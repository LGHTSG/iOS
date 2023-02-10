//
//  AccountSettingViewController.swift
//  LGHTSG
//
//  Created by 홍수정 on 2023/02/06.
//


// MARK: 버튼 크기때문에 바꿔야함
// MARK: 비번바꾸기 해줘야함
import UIKit
import Alamofire

class AccountSettingViewController: UIViewController, UIGestureRecognizerDelegate {

    let navigationBar : UINavigationBar = {
        let navigationBar = UINavigationBar()
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        return navigationBar
    }()
    
    
    var profileImageData : String!
    
    // MARK: imagePicker
    var profileImagePicker = UIImagePickerController()
    
    
    // MARK: profileImageView
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
    
    // MARK: 사용자 이름
    let nameImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "text-field")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let nameTextLabel: UILabel = {
        let name = UILabel()
        name.text = "라고함"
        name.textColor = .white // 글자색을 흰색으로
        name.font = UIFont(name: "NanumSquareR", size: 16.0)
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    
    // MARK: 사용자 이메일
    let emailImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "text-field")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let emailTextLabel: UILabel = {
        let name = UILabel()
        name.text = "abc123@rghtsg.com"
        name.textColor = .white // 글자색을 흰색으로
        name.font = UIFont(name: "NanumSquareR", size: 16.0)
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    
    // MARK: 사용자 비밀번호
    let passwordImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "text-field")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let passwordTextLabel: UITextField = {
        let name = UITextField()
        name.leftViewMode = .always
        name.attributedPlaceholder = NSAttributedString(string: "비밀번호", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        name.borderStyle = .none
        name.textColor = .white // 글자색을 흰색으로
        name.isSecureTextEntry = true
        name.font = UIFont(name: "NanumSquareR", size: 16.0)
        name.addTarget(self, action: #selector(pwFieldEdited2), for: UIControl.Event.editingChanged)
        name.enablesReturnKeyAutomatically = true
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    let passwordValidLabel: UILabel = {
        let label = UILabel()
        label.text = "영문, 숫자, 특수문자를 포함한 7자 이상으로 입력해주세요."
        label.font = UIFont(name: "NanumSquareR", size: 12.0)
        label.textColor = .systemRed
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    // MARK: 사용자 비밀번호 확인
    let passwordCheckImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "text-field")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let passwordCheckTextLabel: UITextField = {
        let name = UITextField()
        name.leftViewMode = .always
        name.attributedPlaceholder = NSAttributedString(string: "비밀번호 확인", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        name.borderStyle = .none
        name.textColor = .white // 글자색을 흰색으로
        name.isSecureTextEntry = true
        name.font = UIFont(name: "NanumSquareR", size: 16.0)
        name.addTarget(self, action: #selector(pwFieldEdited2), for: UIControl.Event.editingChanged)
        name.enablesReturnKeyAutomatically = true
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    let passwordSameLabel: UILabel = {
        let label = UILabel()
        label.text = "비밀번호가 일치하지 않습니다."
        label.font = UIFont(name: "NanumSquareR", size: 12.0)
        label.textColor = .systemRed
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let saveBtn: UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(named: "not-save-btn"), for: .normal)
        btn.addTarget(self, action: #selector(saveBtnClicked), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    var save : Bool = false
    
    @objc func saveBtnClicked(){
        if save == true{
            
            //Alert 선언
            let msg = UIAlertController(title: "", message: "비밀번호를 변경하시겠습니까?", preferredStyle: .alert)
            
            //Alert에 부여할 Yes이벤트 선언
            let YES = UIAlertAction(title: "예", style: .default, handler: { (action) -> Void in
                self.YesClick()
            })
            
            //Alert에 부여할 No이벤트 선언
            let NO = UIAlertAction(title: "아니요", style: .cancel) { (action) -> Void in
                self.NoClick()
            }
            
            //Alert에 이벤트 연결
            msg.addAction(NO)
            msg.addAction(YES)

            //Alert 호출
            self.present(msg, animated: true, completion: nil)
            
        }
        else {
            print("아직 비밀번호를 바꿀 수 없음.")
        }
    }
    
    func YesClick()
    {
        
        
        var jwt : String = UserDefaults.standard.string(forKey: "savedToken") ?? ""
        
        let header : HTTPHeaders = [
            "x-access-token" : jwt]
        
        var pastPassword : String = UserDefaults.standard.string(forKey: "pastPassword") ?? ""
        print(pastPassword)
        
        let changePw = PasswordApiModel()
        guard let password = passwordTextLabel.text else {return}
        
        let bodyData : Parameters = [
            "pastPassword" : pastPassword,
            "password" : password
        ]
                
        changePw.requestChangeDataModel(header: header, bodyData: bodyData){
            data in
            
            //Alert 선언
            let msg = UIAlertController(title: "", message: "비밀번호 변경이 완료되었습니다", preferredStyle: .alert)
            //Alert에 부여할 Yes이벤트 선언
            let YES = UIAlertAction(title: "확인", style: .default, handler: { (action) in
            })
            msg.addAction(YES)
            self.present(msg, animated: true, completion: nil)

        }
        
    }
    
    func NoClick()
    {
        print("아니요를 눌렀음")
    }
    
    // MARK: 패스워드 맞는지 확인하는 함수
    func isSamePassword2(_ first: UITextField, _ second: UITextField) -> Bool {
        if (first.text == second.text){
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
                return true
            }
        }
        return false
    }
    
    
    var isCheck3 : Bool = false
    var isCheck4 : Bool = false
    
    // MARK: 패스워드의 결과에 따라 메세지를 보여줄지 여부를 정하는 코드
    @objc func pwFieldEdited2(textField: UITextField) {
        
        if textField == passwordTextLabel {
            if isValidPassword2(pw: passwordTextLabel.text)
            {
                print("유효함")
                passwordValid.isActive = true
                isCheck3 = true
                if isCheck3 == true && isCheck4 == true {
                    saveBtn.setBackgroundImage(UIImage(named: "save-btn"), for: .normal)
                    save = true
                    saveBtn.contentMode = .scaleAspectFill
                }
                else {
                    saveBtn.setBackgroundImage(UIImage(named: "not-save-btn"), for: .normal)
                }
            }
            else{
                print("유효하지않음")
                save = false
                saveBtn.setBackgroundImage(UIImage(named: "not-save-btn"), for: .normal)
                passwordValid.isActive = false
                isCheck3 = false
                
            }
        }
        
        else if textField == passwordCheckTextLabel {
            if isSamePassword2(passwordTextLabel, passwordCheckTextLabel)
            {
                print("같음")
                passwordSame.isActive = true
                isCheck4 = true
                
                if isCheck3 == true && isCheck4 == true {
                    saveBtn.setBackgroundImage(UIImage(named: "save-btn"), for: .normal)
                    save = true
                    saveBtn.contentMode = .scaleToFill
                }
                else {
                    saveBtn.setBackgroundImage(UIImage(named: "not-save-btn"), for: .normal)
                }
            }
            else{
                print("다름")
                save = false
                saveBtn.setBackgroundImage(UIImage(named: "not-save-btn"), for: .normal)
                passwordSame.isActive = false
                isCheck4 = false
            }
        }
    }

    
    let user = UserApiModel()
    func loadData(){
        // MARK: 토큰 가져오기
        var jwt : String = UserDefaults.standard.string(forKey: "savedToken") ?? ""

        user.requestUserDataModel(bodyData: jwt){ [self]
            data in
            self.emailTextLabel.text = data.email
            self.nameTextLabel.text = data.name
            print(data.email)
            print(data.name)
        }
    }
    
    
    @objc func tapDismissButton(){
        self.presentingViewController?.dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        AutoLayout()
        loadData()
        
        // MARK: 키보드 올라갔을 때 화면 터치해서 내려가게함
        let tapGesture = UITapGestureRecognizer(target: self.view, action: #selector(self.view.endEditing(_:)))
        tapGesture.delegate = self
        self.view.addGestureRecognizer(tapGesture)
        
        
        // MARK: 네비게이션 컨트롤러
        self.view.addSubview(navigationBar)
        let safeArea = self.view.safeAreaLayoutGuide
        let navigationAppearance = UINavigationBarAppearance()
        
        navigationAppearance.backgroundColor = .black
        navigationAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationBar.tintColor = UIColor.white
        navigationBar.standardAppearance = navigationAppearance
        navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        navigationBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        navigationBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        
        let navItem = UINavigationItem(title: "계정 설정")
        let leftButton = UIBarButtonItem(image: UIImage(named: "back-arrow"), style: .plain, target: self, action: #selector(tapDismissButton))
        
        navItem.leftBarButtonItem = leftButton
        navigationBar.setItems([navItem], animated: true)
    }
    
    
    // MARK: 패스워드 관련 동적 변화 라벨
    var passwordValid: NSLayoutConstraint!
    var passwordSame: NSLayoutConstraint!
    
    
    func AutoLayout(){
        view.addSubview(profileImageView)
        view.addSubview(nameImageView)
        view.addSubview(nameTextLabel)
        
        view.addSubview(emailImageView)
        view.addSubview(emailTextLabel)
        
        view.addSubview(passwordImageView)
        view.addSubview(passwordTextLabel)
        view.addSubview(passwordValidLabel)
        
        view.addSubview(passwordCheckImageView)
        view.addSubview(passwordCheckTextLabel)
        view.addSubview(passwordSameLabel)
        
        view.addSubview(saveBtn)

        
        
        passwordValid = passwordValidLabel.heightAnchor.constraint(equalToConstant: 0)
        passwordValid.isActive = true
        passwordSame = passwordSameLabel.heightAnchor.constraint(equalToConstant: 0)
        passwordSame.isActive = true
        
        
        
        // MARK: profile 위치 설정
        self.profileImageView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(150)
            $0.centerX.equalToSuperview()
        }
        
        profileImageView.snp.makeConstraints { make in
            make.height.equalTo(85)
            make.width.equalTo(85)
        }
        
        
        // MARK: 이름 설정 위치
        self.nameImageView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(280)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
        }
        
        self.nameTextLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(295)
            $0.left.equalToSuperview().offset(35)
            $0.right.equalToSuperview().offset(-20)
        }
        
        // MARK: 이메일 작성 및 전송 버튼 위치
        self.emailImageView.snp.makeConstraints{
            $0.top.equalTo(nameImageView.snp.bottom).offset(30)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
        }
        
        self.emailTextLabel.snp.makeConstraints{
            $0.top.equalTo(nameImageView.snp.bottom).offset(45)
            $0.left.equalToSuperview().offset(35)
            $0.right.equalToSuperview().offset(-120)
        }
        
        self.passwordImageView.snp.makeConstraints{
            $0.top.equalTo(emailImageView.snp.bottom).offset(30)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
        }
        
        self.passwordTextLabel.snp.makeConstraints{
            $0.top.equalTo(emailImageView.snp.bottom).offset(45)
            $0.left.equalToSuperview().offset(35)
            $0.right.equalToSuperview().offset(-120)
        }
        
        self.passwordValidLabel.snp.makeConstraints{
            $0.top.equalTo(passwordImageView.snp.bottom).offset(5)
            $0.left.equalTo(passwordImageView.snp.left)
        }
        
        self.passwordCheckImageView.snp.makeConstraints{
            $0.top.equalTo(passwordImageView.snp.bottom).offset(30)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
        }
        
        self.passwordCheckTextLabel.snp.makeConstraints{
            $0.top.equalTo(passwordImageView.snp.bottom).offset(45)
            $0.left.equalToSuperview().offset(35)
            $0.right.equalToSuperview().offset(-120)
        }
        
        self.passwordSameLabel.snp.makeConstraints{
            $0.top.equalTo(passwordCheckImageView.snp.bottom).offset(5)
            $0.left.equalTo(passwordCheckImageView.snp.left)
        }
        
        // MARK: 저장 버튼
        self.saveBtn.snp.makeConstraints{
            $0.bottom.equalToSuperview().offset(-50)
            $0.left.equalToSuperview().offset(40)
            $0.right.equalToSuperview().offset(-40)
            $0.height.equalTo(passwordImageView.snp.height)
        }
        
    }


}
