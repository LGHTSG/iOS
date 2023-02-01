//
//  MyPageController.swift
//  LGHTSG
//
//  Created by 홍수정 on 2023/01/26.
//

import UIKit

class MyPageController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let MyPageView = MyPageView()
        view.addSubview(MyPageView)
        
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
            
        //MyPageView.navigationBar2.setItems([navItem], animated: true)
        
        
        // MARK: 화면 전환이나 실행함수
        //MyPageView.nextBtn.addTarget(self, action: #selector(nextBtnClicked), for: .touchUpInside)

    }
    
    @objc func tapDismissButton(){
        self.presentingViewController?.dismiss(animated: true)

    }

}
