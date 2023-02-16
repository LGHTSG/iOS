//
//  RegisterationSuccessController.swift
//  LGHTSG
//
//  Created by 홍수정 on 2023/01/28.
//

import UIKit

class RegisterationSuccessController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        let JoinSuccessView = JoinSuccessView()
        JoinSuccessView.successBtn.addTarget(self, action: #selector(MoveHomeTab), for: .touchUpInside)
        view.addSubview(JoinSuccessView)
        JoinSuccessView.translatesAutoresizingMaskIntoConstraints = false
        JoinSuccessView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        JoinSuccessView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        JoinSuccessView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        JoinSuccessView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }

    
    @objc func MoveHomeTab(){
        
        
        //Alert 선언
        let msg = UIAlertController(title: "", message: "회원가입이 완료되었습니다.\n앱을 다시 실행하여 시작해보세요 :)", preferredStyle: .alert)
        //Alert에 부여할 Yes이벤트 선언
        let YES = UIAlertAction(title: "확인", style: .default, handler: { (action) -> Void in
            self.YesClick2()
        })
        
        // MARK: 자동로그인을 못하게 막는다
        UserDefaults.standard.set(false, forKey: "loginSuccess")
        
        msg.addAction(YES)
        self.present(msg, animated: true, completion: nil)
    }
    
    @objc func YesClick2(){
        UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {exit(0)
        }
    }
}
