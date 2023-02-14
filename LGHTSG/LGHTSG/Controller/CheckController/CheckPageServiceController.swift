//
//  CheckPageServiceController.swift
//  LGHTSG
//
//  Created by 홍수정 on 2023/01/25.
//

import UIKit

class CheckPageServiceController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let CheckPageServiceView = CheckPageServiceView()
        view.backgroundColor = .black
        view.addSubview(CheckPageServiceView)
        
        CheckPageServiceView.translatesAutoresizingMaskIntoConstraints = false
        CheckPageServiceView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        CheckPageServiceView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        CheckPageServiceView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        CheckPageServiceView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        
        // MARK: 네비게이션 컨트롤러
        self.view.addSubview(CheckPageServiceView.navigationBar4)
        let safeArea = self.view.safeAreaLayoutGuide
        let navigationAppearance = UINavigationBarAppearance()
        
        navigationAppearance.backgroundColor = .black
        navigationAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        CheckPageServiceView.navigationBar4.tintColor = UIColor.white
        CheckPageServiceView.navigationBar4.standardAppearance = navigationAppearance
        CheckPageServiceView.navigationBar4.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        CheckPageServiceView.navigationBar4.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        CheckPageServiceView.navigationBar4.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        let navItem = UINavigationItem(title: "서비스 이용약관")
        let leftButton = UIBarButtonItem(image: UIImage(named: "back-arrow"), style: .plain, target: self, action: #selector(tapDismissButton))
        
        navItem.leftBarButtonItem = leftButton
            
        CheckPageServiceView.navigationBar4.setItems([navItem], animated: true)
        CheckPageServiceView.nextLabel3.addTarget(self, action: #selector(tapDismissButton), for: .touchUpInside)
    }
    
    @objc func tapDismissButton(){
        UserDefaults.standard.set(true, forKey: "check2")
        self.presentingViewController?.dismiss(animated: true)
    }
            


}
