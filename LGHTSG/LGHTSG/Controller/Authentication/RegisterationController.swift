//
//  RegisterationController.swift
//  LGHTSG
//
//  Created by HA on 2023/01/09.
//

import UIKit
import Alamofire

class RegisterationController: UIViewController {

    
    
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
    
    // MARK: imagePicker
    var profileImagePicker = UIImagePickerController()
    
    
    // MARK: https://mansu.tistory.com/120
    override func viewDidLoad() {
        super.viewDidLoad()
        let RegisterView = RegisterView()
        
        view.backgroundColor = .black
        view.addSubview(profileImageView)
        view.addSubview(RegisterView)
        
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
                
        RegisterView.translatesAutoresizingMaskIntoConstraints = false
        RegisterView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor).isActive = true
        RegisterView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        RegisterView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        RegisterView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        
        // MARK: 키보드 올라갔을 때 화면 터치해서 내려가게함
        let tapGesture = UITapGestureRecognizer(target: self.view, action: #selector(self.view.endEditing(_:)))
        self.view.addGestureRecognizer(tapGesture)
        // MARK: 키보드가 화면을 가릴 때 화면을 위로 올릴 수 있도록
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil);
        
        
        // MARK: 네비게이션 컨트롤러
        self.view.addSubview(RegisterView.navigationBar2)
        let safeArea = self.view.safeAreaLayoutGuide
        let navigationAppearance = UINavigationBarAppearance()
        
        navigationAppearance.backgroundColor = .black
        navigationAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        RegisterView.navigationBar2.tintColor = UIColor.white
        RegisterView.navigationBar2.standardAppearance = navigationAppearance
        RegisterView.navigationBar2.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        RegisterView.navigationBar2.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        RegisterView.navigationBar2.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        let navItem = UINavigationItem(title: "회원가입")
        let leftButton = UIBarButtonItem(image: UIImage(named: "back-arrow"), style: .plain, target: self, action: #selector(tapDismissButton))
        
        navItem.leftBarButtonItem = leftButton
            
        RegisterView.navigationBar2.setItems([navItem], animated: true)
        
        
        // MARK: 화면 전환이나 실행함수
        RegisterView.nextBtn.addTarget(self, action: #selector(joinBtnClicked2), for: .touchUpInside)
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
                let userName = RegisterView.nameTextField.text
                let email = RegisterView.emailTextField3.text
                let password = RegisterView.passwordTextField3.text
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
    
    
    // MARK: 프로필 설정
    @objc func changeProfile(){
        profileImagePicker.sourceType = .photoLibrary
        profileImagePicker.allowsEditing = false
        profileImagePicker.delegate = self
        present(profileImagePicker, animated: true)
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
