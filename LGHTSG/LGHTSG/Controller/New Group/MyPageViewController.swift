//
//  MyPageViewController.swift
//  LGHTSG
//
//  Created by 홍수정 on 2023/02/01.
//

import UIKit

class MyPageViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let MyPageView = MyPageView()
        self.view.addSubview(MyPageView)
        view.backgroundColor = .black
        
        
        MyPageView.translatesAutoresizingMaskIntoConstraints = false
        MyPageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        MyPageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        MyPageView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        MyPageView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        
        // MARK: 네비게이션 컨트롤러
        self.view.addSubview(MyPageView.navigationBar7)
        let safeArea = self.view.safeAreaLayoutGuide
        let navigationAppearance = UINavigationBarAppearance()
        
        navigationAppearance.backgroundColor = .black
        navigationAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        MyPageView.navigationBar7.tintColor = UIColor.white
        MyPageView.navigationBar7.standardAppearance = navigationAppearance
        MyPageView.navigationBar7.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        MyPageView.navigationBar7.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        MyPageView.navigationBar7.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        let navItem = UINavigationItem(title: "마이페이지")
        let leftButton = UIBarButtonItem(image: UIImage(named: "back-arrow"), style: .plain, target: self, action: #selector(tapDismissButton))
        
        navItem.leftBarButtonItem = leftButton
            
        MyPageView.navigationBar7.setItems([navItem], animated: true)
        
        // MARK: 계정 설정으로 감
        MyPageView.button1.addTarget(self, action: #selector(accountSettingClicked), for: .touchUpInside)

        // MARK: 로그아웃 하도록 함
        MyPageView.logoutBtn.addTarget(self, action: #selector(logoutBtnClicked), for: .touchUpInside)

    }
    
    @objc func logoutBtnClicked(){
        UserDefaults.standard.set(nil,forKey: "savedToken")
        let vc = LoginController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    @objc func tapDismissButton(){
        self.presentingViewController?.dismiss(animated: true)
    }
    
    @objc func accountSettingClicked(){
        let vc = AccountSettingViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }


}

    
