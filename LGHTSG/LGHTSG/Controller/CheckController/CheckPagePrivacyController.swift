//
//  CheckPagePrivacyController.swift
//  LGHTSG
//
//  Created by 홍수정 on 2023/01/25.
//

import UIKit

class CheckPagePrivacyController: UIViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        let CheckPagePrivacyView = CheckPagePrivacyView()
        view.backgroundColor = .black
        view.addSubview(CheckPagePrivacyView)
        
        CheckPagePrivacyView.translatesAutoresizingMaskIntoConstraints = false
        CheckPagePrivacyView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        CheckPagePrivacyView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        CheckPagePrivacyView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        CheckPagePrivacyView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        
        // MARK: 네비게이션 컨트롤러
        self.view.addSubview(CheckPagePrivacyView.navigationBar5)
        let safeArea = self.view.safeAreaLayoutGuide
        let navigationAppearance = UINavigationBarAppearance()
        
        navigationAppearance.backgroundColor = .black
        navigationAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        CheckPagePrivacyView.navigationBar5.tintColor = UIColor.white
        CheckPagePrivacyView.navigationBar5.standardAppearance = navigationAppearance
        CheckPagePrivacyView.navigationBar5.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        CheckPagePrivacyView.navigationBar5.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        CheckPagePrivacyView.navigationBar5.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        let navItem = UINavigationItem(title: "개인정보 처리방침")
        let leftButton = UIBarButtonItem(image: UIImage(named: "back-arrow"), style: .plain, target: self, action: #selector(tapDismissButton))
        
        navItem.leftBarButtonItem = leftButton
        CheckPagePrivacyView.navigationBar5.setItems([navItem], animated: true)
        CheckPagePrivacyView.nextLabel4.addTarget(self, action: #selector(tapDismissButton), for: .touchUpInside)

    }
    
    @objc func tapDismissButton(){
        self.presentingViewController?.dismiss(animated: true)
    }
    

}
