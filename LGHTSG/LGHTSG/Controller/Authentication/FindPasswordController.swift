import UIKit
import Alamofire


// MARK: 전체적으로 바꿔야함

class FindPassWordController: UIViewController {

    
    
    // MARK: 네비게이션 바 생성
    let navigationBar : UINavigationBar = {
        let navigationBar = UINavigationBar()
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        return navigationBar
    }()
    
    let emailSendImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "send-code-btn")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "인증번호를 요청할 이메일을 입력해주세요."
        label.textColor = .white
        label.font = UIFont(name: "NanumSquareB", size: 15.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        
    let emailTextField2: UITextField = {
        let label = UITextField()
        label.becomeFirstResponder() // 첫번째 입력으로 인식
        label.attributedPlaceholder = NSAttributedString(string: "이메일", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        label.leftViewMode = .always
        label.becomeFirstResponder()
        label.textColor = .white
        label.font = UIFont(name: "NanumSquareR", size: 15.0)
        label.borderStyle = .none
        label.enablesReturnKeyAutomatically = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var emailCodeBtn: UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont(name: "NanumSquareB", size: 12.0)
        //btn.backgroundColor = .red
        btn.layer.cornerRadius = 5
        btn.layer.zPosition = 1000
        btn.addTarget(self, action: #selector(emailCodeBtnClicked), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    
    let codeSendLabel: UILabel = {
        let label = UILabel()
        label.text = "인증번호가 발송되었습니다"
        label.font = UIFont(name: "NanumSquareR", size: 12.0)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let codeTextField: UITextField = {
        let label = UITextField()
        label.attributedPlaceholder = NSAttributedString(string: "인증번호", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        label.leftViewMode = .always
        label.textColor = .white
        label.font = UIFont(name: "NanumSquareR", size: 15.0)
        label.borderStyle = .none
        label.enablesReturnKeyAutomatically = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let codeSendImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "confirm-code-btn")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    
    let codeSuccessLabel: UILabel = {
        let label = UILabel()
        label.text = "⎷ 이메일 인증이 완료되었습니다."
        label.font = UIFont(name: "NanumSquareR", size: 12.0)
        label.textColor = .systemGreen
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    lazy var codeConfirmBtn: UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont(name: "NanumSquareB", size: 12.0)
        //btn.backgroundColor = .blue
        btn.layer.cornerRadius = 5
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(codeConfirmBtnClicked), for: .touchUpInside)
        return btn
    }()
    
    
    let codeConfirmLabel: UILabel = {
        let label = UILabel()
        label.text = "인증번호가 일치하지 않습니다."
        label.font = UIFont(name: "NanumSquareR", size: 12.0)
        label.textColor = .systemRed
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "변경할 비밀번호를 입력해주세요"
        label.textColor = .white
        label.font = UIFont(name: "NanumSquareB", size: 15.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let passwordTextField2: UITextField = {
        let password = UITextField()
        password.layer.cornerRadius = 5
        password.leftViewMode = .always
        password.attributedPlaceholder = NSAttributedString(string: "비밀번호", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        password.borderStyle = .none
        password.textColor = .white // 글자색을 흰색으로
        password.isSecureTextEntry = true
        password.font = UIFont(name: "NanumSquareR", size: 15.0)
        password.resignFirstResponder()
        
        password.addTarget(self, action: #selector(pwFieldEdited), for: UIControl.Event.editingChanged)
        password.translatesAutoresizingMaskIntoConstraints = false
        return password
    }()
    
    let pwImageView2: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "text-field")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    
    let pwValidLabel: UILabel = {
        let label = UILabel()
        label.text = "영문, 숫자, 특수문자를 포함한 7자 이상으로 입력해주세요."
        label.font = UIFont(name: "NanumSquareR", size: 12.0)
        label.textColor = .systemRed
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    
    let passwordCheckTextField2: UITextField = {
        let password = UITextField()
        password.layer.cornerRadius = 5
        password.leftViewMode = .always
        password.attributedPlaceholder = NSAttributedString(string: "비밀번호 확인", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        password.borderStyle = .none
        password.textColor = .white // 글자색을 흰색으로
        password.isSecureTextEntry = true
        password.font = UIFont(name: "NanumSquareR", size: 15.0)
        password.resignFirstResponder()
        password.addTarget(self, action: #selector(pwFieldEdited), for: UIControl.Event.editingChanged)
        password.translatesAutoresizingMaskIntoConstraints = false
        return password
    }()
    
    let pwCheckImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "text-field")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    
    let pwSameLabel: UILabel = {
        let label = UILabel()
        label.text = "비밀번호가 일치하지 않습니다."
        label.font = UIFont(name: "NanumSquareR", size: 12.0)
        label.textColor = .systemRed
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nextBtnImageView2 : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "text-field")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let pwChangeBtn : UIButton = {
        let label = UIButton()
        label.setTitle("비밀번호 변경하기", for: .normal)
        label.titleLabel?.font = UIFont(name: "NanumSquareB", size: 15.0)
        label.titleLabel?.textColor = .white
        label.titleLabel?.textAlignment = .center
        label.addTarget(self, action: #selector(changePwBtnClicked), for: .touchUpInside)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    
    
    let emailCode = emailApiModel()
    var code : String = "dklsfjkljdlvnmnxlmnszlksjwr091u3tghjkfnm,gdsajlkfjsclxnm,zbghjkjilekdsfkhglksefmdfbjfo;gsdlfknjbldkgs"
    
    
    // MARK: 인증번호 발송 함수
    @objc func emailCodeBtnClicked(){
        print("인증번호 발송버튼")
        guard let email = emailTextField2.text else {return}
        
        let bodyData : Parameters = [
            "email" : email,
        ]
        
        emailCode.requestEmailDataModel(bodyData: bodyData){
            data in
            self.code = data.body
            print(self.code)
        }
        sendCodeheight.isActive = false
    }
    
    
    // MARK: 인증번호 확인 함수
    @objc func codeConfirmBtnClicked(){
        if codeTextField.text == self.code {
            codeConfirmheight.isActive = true
            emailTextField2.isUserInteractionEnabled = false
            codeTextField.isUserInteractionEnabled = false
            showPwChange()
            codeConfirmSuccessheight.isActive = false
            codeConfirmheight.isActive = true
        }
        else {
            codeConfirmheight.isActive = false
        }
    }
    
    // MARK: 패스워드 맞는지 확인하는 함수
    func isSamePassword(_ first: UITextField, _ second: UITextField) -> Bool {
        if (first.text == second.text){
            return true
        }
        return false
    }
    
    // MARK: 패스워드 유효한지 확인 함수
    func isValidPassword(pw: String?) -> Bool{
        
        let regex = "^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[!@#$%^&*()_+=-]).{8,50}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        
           if let hasPassword = pw{
               // 길이 확인
               if hasPassword.count > 7  && predicate.evaluate(with: hasPassword){
                   print("패스워드 유효")
                   return true
               }
           }
           return false
       }
    
    
    var isCheck1 : Bool = false
    var isCheck2 : Bool = false

    // MARK: 패스워드의 결과에 따라 메세지를 보여줄지 여부를 정하는 코드
    @objc func pwFieldEdited(textField: UITextField) {
        
        if textField == passwordTextField2 {
            if isValidPassword(pw: passwordTextField2.text)
            {
                print("유효함")
                pwheight1.isActive = true
                isCheck1 = true
            }
            else{
                print("유효하지않음")
                pwheight1.isActive = false
                isCheck1 = false

            }
            
            if isCheck1 == true && isCheck2 == true{
                pwChangeBtn.titleLabel?.textColor = .blue
                pwCheckImageView.image = UIImage(named: "highlight-btn")
                
            }
            else{
                pwChangeBtn.titleLabel?.textColor = .white
                pwCheckImageView.image = UIImage(named: "text-field")
            }
        }
        
        else if textField == passwordCheckTextField2 {
            if isSamePassword(passwordTextField2, passwordCheckTextField2)
            {
                print("같음")
                pwheight2.isActive = true
                isCheck2 = true
            }
            else{
                print("다름")
                pwheight2.isActive = false
                isCheck2 = false
            }
            if isCheck1 == true && isCheck2 == true{
                pwChangeBtn.titleLabel?.textColor = .blue
                nextBtnImageView2.image = UIImage(named: "highlight-btn")
                
            }
            else{
                pwChangeBtn.titleLabel?.textColor = .white
                nextBtnImageView2.image = UIImage(named: "text-field")
            }
            
        }
    }
    
    
    let changePw = ChangePwApiModel()
    
    
    @objc func changePwBtnClicked(){
        print("isCheck1=\(isCheck1), isCheck2=\(isCheck2)")
        if isCheck1 == true {
            if isCheck2 == true {
                print("비밀번호 변경 가능")
            }
        }
        
        guard let email = emailTextField2.text else {return}
        guard let password = passwordTextField2.text else {return}
        

        let bodyData : Parameters = [
            "email" : email,
            "password" : password
        ]
                
        changePw.requestChangeDataModel(bodyData: bodyData){
            data in
            print(data.body)
            
            //Alert 선언
            let msg = UIAlertController(title: "", message: "비밀번호 변경이 완료되었습니다", preferredStyle: .alert)
            //Alert에 부여할 Yes이벤트 선언
            let YES = UIAlertAction(title: "확인", style: .default, handler: { (action) -> Void in
                self.YesClick3()
            })
            msg.addAction(YES)
            self.present(msg, animated: true, completion: nil)
            self.pwChangeBtn.titleLabel?.textColor = .blue
        }
    }
    
    @objc func YesClick3(){
        self.presentingViewController?.dismiss(animated: true)
    }
    
    
    // MARK: 인증번호 관련 동적 변화 라벨
    var sendCodeheight: NSLayoutConstraint!
    var codeConfirmheight: NSLayoutConstraint!
    var codeConfirmSuccessheight: NSLayoutConstraint!
    
    // MARK: 인증번호가 성공적이면 비밀번호 바꿀 수 있도록 함
    var codeSuccessheight: NSLayoutConstraint!
    var codeSuccessheight1: NSLayoutConstraint!
    var codeSuccessheight2: NSLayoutConstraint!
    var codeSuccessheight3: NSLayoutConstraint!
    var codeSuccessheight4: NSLayoutConstraint!
    
    
    // MARK: 비밀번호에 따른 메세지
    var pwheight1: NSLayoutConstraint!
    var pwheight2: NSLayoutConstraint!


    func heightSetting(){
        
        sendCodeheight = codeSendLabel.heightAnchor.constraint(equalToConstant: 0)
        sendCodeheight.isActive = true
        
        codeConfirmheight = codeConfirmLabel.heightAnchor.constraint(equalToConstant: 0)
        codeConfirmheight.isActive = true

        codeSuccessheight = passwordLabel.heightAnchor.constraint(equalToConstant: 0)
        codeSuccessheight.isActive = true
        
        codeSuccessheight1 = pwImageView2.heightAnchor.constraint(equalToConstant: 0)
        codeSuccessheight1.isActive = true
        
        codeSuccessheight2 = passwordTextField2.heightAnchor.constraint(equalToConstant: 0)
        codeSuccessheight2.isActive = true
        
        codeSuccessheight3 = pwCheckImageView.heightAnchor.constraint(equalToConstant: 0)
        codeSuccessheight3.isActive = true
        
        codeSuccessheight4 = passwordCheckTextField2.heightAnchor.constraint(equalToConstant: 0)
        codeSuccessheight4.isActive = true
        
        codeConfirmSuccessheight = codeSuccessLabel.heightAnchor.constraint(equalToConstant: 0)
        codeConfirmSuccessheight.isActive = true
        
        pwheight1 = pwValidLabel.heightAnchor.constraint(equalToConstant: 0)
        pwheight1.isActive = true
        
        pwheight2 = pwSameLabel.heightAnchor.constraint(equalToConstant: 0)
        pwheight2.isActive = true
    }
    
    
    func showPwChange(){
        codeSuccessheight.isActive = false
        codeSuccessheight1.isActive = false
        codeSuccessheight2.isActive = false
        codeSuccessheight3.isActive = false
        codeSuccessheight4.isActive = false
    }
    
    func highlightButton(){
        if isCheck1 == true && isCheck2 == true{
            pwChangeBtn.titleLabel?.textColor = .systemBlue
            nextBtnImageView2.image = UIImage(named: "text-field")
        }
        
        else{
            pwChangeBtn.titleLabel?.textColor = .white
            nextBtnImageView2.image = UIImage(named: "highlight-btn")
        }

    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
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
        
        let navItem = UINavigationItem(title: "비밀번호 변경")
        let leftButton = UIBarButtonItem(image: UIImage(named: "back-arrow"), style: .plain, target: self, action: #selector(tapDismissButton))
        
        navItem.leftBarButtonItem = leftButton
            
        navigationBar.setItems([navItem], animated: true)

        heightSetting()
        
        view.addSubview(emailLabel)
        view.addSubview(emailSendImageView)
        view.addSubview(emailTextField2)
        view.addSubview(codeSendLabel)
        
        view.addSubview(codeSendImageView)
        view.addSubview(codeTextField)
        view.addSubview(codeConfirmLabel)
        view.addSubview(codeSuccessLabel)
        
        
        view.addSubview(passwordLabel)
        view.addSubview(pwImageView2)
        view.addSubview(passwordTextField2)
        
        
        view.addSubview(pwCheckImageView)
        view.addSubview(passwordCheckTextField2)
        view.addSubview(pwValidLabel)
        
        view.addSubview(nextBtnImageView2)
        view.addSubview(pwChangeBtn)
        view.addSubview(pwSameLabel)
        
        view.addSubview(emailCodeBtn)
        view.addSubview(codeConfirmBtn)
                
        view.addSubview(codeConfirmBtn)

        
        
        self.emailLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(140)
            $0.left.equalToSuperview().offset(20)
        }
        
        // MARK: 이메일 작성 및 전송 버튼 위치
        self.emailSendImageView.snp.makeConstraints{
            $0.top.equalTo(emailLabel.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
        }
        
        self.emailTextField2.snp.makeConstraints{
            $0.top.equalTo(emailLabel.snp.bottom).offset(45)
            $0.left.equalToSuperview().offset(28)
            $0.right.equalToSuperview().offset(-120)
        }
        
        self.emailCodeBtn.snp.makeConstraints{
            $0.top.equalTo(emailLabel.snp.bottom).offset(30)
            $0.left.equalTo(emailTextField2.snp.right).offset(5)
            $0.right.equalTo(emailSendImageView.snp.right)
            $0.height.equalTo(emailSendImageView).offset(0)
        }
        
        // MARK: 인증번호 보냈다는 메세지 띄움
        self.codeSendLabel.snp.makeConstraints{
            $0.top.equalTo(emailSendImageView.snp.bottom).offset(5)
            $0.left.equalTo(emailSendImageView.snp.left)
        }
        
        
        // MARK: 인증번호 작성 및 확인 버튼 위치
        self.codeSendImageView.snp.makeConstraints{
            $0.top.equalTo(emailSendImageView.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
        }
        
        self.codeTextField.snp.makeConstraints{
            $0.top.equalTo(emailSendImageView.snp.bottom).offset(45)
            $0.left.equalToSuperview().offset(28)
            $0.right.equalToSuperview().offset(-120)
        }
        
        
        self.codeConfirmBtn.snp.makeConstraints{
            $0.top.equalTo(emailSendImageView.snp.bottom).offset(30)
            $0.left.equalTo(codeTextField.snp.right).offset(5)
            $0.height.equalTo(codeSendImageView).offset(0)
            $0.right.equalTo(codeSendImageView.snp.right)
        }
        
        
        // MARK: 인증번호가 다르다는 메세지를 띄움
        self.codeConfirmLabel.snp.makeConstraints{
            $0.top.equalTo(codeSendImageView.snp.bottom).offset(5)
            $0.left.equalTo(codeSendImageView.snp.left)
        }
        
        // MARK: 인증번호가 다르다는 메세지를 띄움
        self.codeSuccessLabel.snp.makeConstraints{
            $0.top.equalTo(codeSendImageView.snp.bottom).offset(5)
            $0.left.equalTo(codeSendImageView.snp.left)
        }
        
        
        // MARK: 비밀번호 변경 파트
        self.passwordLabel.snp.makeConstraints{
            $0.top.equalTo(codeSendImageView.snp.bottom).offset(100)
            $0.left.equalToSuperview().offset(20)
        }
        
        // MARK: 패스워드 변경 위치
        self.pwImageView2.snp.makeConstraints{
            $0.top.equalTo(passwordLabel.snp.bottom).offset(30)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
        }
        
        self.passwordTextField2.snp.makeConstraints{
            $0.top.equalTo(passwordLabel.snp.bottom).offset(45)
            $0.left.equalToSuperview().offset(28)
            $0.right.equalToSuperview().offset(-20)
        }
        
        self.pwValidLabel.snp.makeConstraints{
            $0.top.equalTo(pwImageView2.snp.bottom).offset(5)
            $0.left.equalTo(pwImageView2.snp.left)
        }
        
        
        // MARK: 비밀번호 체크
        self.pwCheckImageView.snp.makeConstraints{
            $0.top.equalTo(pwImageView2.snp.bottom).offset(30)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            
        }
        
        self.passwordCheckTextField2.snp.makeConstraints{
            $0.top.equalTo(pwImageView2.snp.bottom).offset(45)
            $0.left.equalToSuperview().offset(28)
            $0.right.equalToSuperview().offset(-20)
        }
        
        
        // MARK: 비밀번호 같은지 체크
        self.pwSameLabel.snp.makeConstraints{
            $0.top.equalTo(pwCheckImageView.snp.bottom).offset(5)
            $0.left.equalTo(pwCheckImageView.snp.left)

        }
        
        
        // MARK: 비밀번호 변경 버튼
        self.nextBtnImageView2.snp.makeConstraints{
            $0.bottom.equalToSuperview().offset(-50)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
        }
        
        self.pwChangeBtn.snp.makeConstraints{
            $0.top.equalTo(nextBtnImageView2).offset(10)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
        }
        
        // MARK: 키보드 올라갔을 때 화면 터치해서 내려가게함
        let tapGesture = UITapGestureRecognizer(target: self.view, action: #selector(self.view.endEditing(_:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func tapDismissButton(){
        var userId = UserDefaults.standard.string(forKey: "id")
        var pw = UserDefaults.standard.string(forKey: "pw")
        
        print("id : \(userId), pw : \(pw)")
        self.presentingViewController?.dismiss(animated: true)
    }

    

    
}
