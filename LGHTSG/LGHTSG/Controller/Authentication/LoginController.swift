//
//  LoginController.swift
//  LGHTSG
//
//  Created by HA on 2023/01/09.
//

import UIKit

class LoginController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        // MARK: 뷰 설정하기
        let LoginView = LoginView()
        self.view.addSubview(LoginView)

        LoginView.translatesAutoresizingMaskIntoConstraints = false
        LoginView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        LoginView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        LoginView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        LoginView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        
        // MARK: 옆으로 넘기면 뒤로 갈 수 있게
        let swipeleft = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(infoviewSwipeLeft))
        swipeleft.edges = .left
        swipeleft.delegate = self
        self.view.addGestureRecognizer(swipeleft)
        
        
        
        // MARK: 화면 이동을 위한 addTarget
        LoginView.findPwBtn2.addTarget(self, action: #selector(findPwClicked), for: .touchUpInside)
        LoginView.joinBtn2.addTarget(self, action: #selector(joinBtnClicked), for: .touchUpInside)
        
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
         print("키보드 내려감")
         self.view.frame.origin.y = 0 // Move view to original position
    }
}


// 제스처 여러개 인식될 수 있도록
extension LoginController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
}
