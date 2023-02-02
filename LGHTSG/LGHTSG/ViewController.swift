//
//  ViewController.swift
//  LGHTSG
//
//  Created by HA on 2023/01/09.
//

import UIKit

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        
        let StartView = StartView()
        self.view.addSubview(StartView)
        
        
        StartView.translatesAutoresizingMaskIntoConstraints = false
        StartView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        StartView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        StartView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        StartView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        
        StartView.loginBtn.addTarget(self, action: #selector(loginBtnClicked), for: .touchUpInside)
        StartView.joinBtn.addTarget(self, action: #selector(joinBtnClicked), for: .touchUpInside)
        StartView.findPwBtn.addTarget(self, action: #selector(findPwBtnClicked), for: .touchUpInside)
    }
    
    @objc func loginBtnClicked() {
        let vc = LoginController()
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }
    
    @objc func joinBtnClicked() {
        let vc = CheckAgreeController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    @objc func findPwBtnClicked(){
        let vc = FindPassWordController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    


}

