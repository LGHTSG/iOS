//
//  CheckPageMarketingController.swift
//  LGHTSG
//
//  Created by 홍수정 on 2023/01/25.
//

import UIKit

class CheckPageMarketingController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let CheckPageMarketingView = CheckPageMarketingView()
        view.backgroundColor = .black
        view.addSubview(CheckPageMarketingView)
        
        CheckPageMarketingView.translatesAutoresizingMaskIntoConstraints = false
        CheckPageMarketingView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        CheckPageMarketingView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        CheckPageMarketingView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        CheckPageMarketingView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        
        // MARK: 네비게이션 컨트롤러
        self.view.addSubview(CheckPageMarketingView.navigationBar6)
        let safeArea = self.view.safeAreaLayoutGuide
        let navigationAppearance = UINavigationBarAppearance()
        
        navigationAppearance.backgroundColor = .black
        navigationAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        CheckPageMarketingView.navigationBar6.tintColor = UIColor.white
        CheckPageMarketingView.navigationBar6.standardAppearance = navigationAppearance
        CheckPageMarketingView.navigationBar6.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        CheckPageMarketingView.navigationBar6.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        CheckPageMarketingView.navigationBar6.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        let navItem = UINavigationItem(title: "마케팅 정보 수신 동의")
        let leftButton = UIBarButtonItem(image: UIImage(named: "back-arrow"), style: .plain, target: self, action: #selector(tapDismissButton))
        
        navItem.leftBarButtonItem = leftButton
            
        CheckPageMarketingView.navigationBar6.setItems([navItem], animated: true)
        CheckPageMarketingView.nextLabel5.addTarget(self, action: #selector(tapDismissButton), for: .touchUpInside)

    }
    
    @objc func tapDismissButton(){
        UserDefaults.standard.set(true, forKey: "check1")
        self.presentingViewController?.dismiss(animated: true)
    }

}
