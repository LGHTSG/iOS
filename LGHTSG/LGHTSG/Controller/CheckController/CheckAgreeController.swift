//
//  CheckAgreeController.swift
//  LGHTSG
//
//  Created by 홍수정 on 2023/01/25.
//

import UIKit

class CheckAgreeController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        let CheckAgreeView = CheckAgreeView()
        view.addSubview(CheckAgreeView)
        
        UserDefaults.standard.set(false, forKey: "allcheck")
        UserDefaults.standard.set(false, forKey: "check1")
        UserDefaults.standard.set(false, forKey: "check2")
        UserDefaults.standard.set(false, forKey: "check3")
        
        CheckAgreeView.translatesAutoresizingMaskIntoConstraints = false
        CheckAgreeView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        CheckAgreeView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        CheckAgreeView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        CheckAgreeView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        
        // MARK: 네비게이션 컨트롤러
        self.view.addSubview(CheckAgreeView.navigationBar3)
        let safeArea = self.view.safeAreaLayoutGuide
        let navigationAppearance = UINavigationBarAppearance()
        
        navigationAppearance.backgroundColor = .black
        navigationAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        CheckAgreeView.navigationBar3.tintColor = UIColor.white
        CheckAgreeView.navigationBar3.standardAppearance = navigationAppearance
        CheckAgreeView.navigationBar3.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        CheckAgreeView.navigationBar3.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        CheckAgreeView.navigationBar3.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        let navItem = UINavigationItem(title: "회원가입")
        let leftButton = UIBarButtonItem(image: UIImage(named: "back-arrow"), style: .plain, target: self, action: #selector(tapDismissButton))
        
        navItem.leftBarButtonItem = leftButton
            
        CheckAgreeView.navigationBar3.setItems([navItem], animated: true)
        CheckAgreeView.agreeBtn1.addTarget(self, action: #selector(agreeBtn1Clicked), for: .touchUpInside)
        CheckAgreeView.agreeBtn2.addTarget(self, action: #selector(agreeBtn2Clicked), for: .touchUpInside)
        CheckAgreeView.agreeBtn3.addTarget(self, action: #selector(agreeBtn3Clicked), for: .touchUpInside)
        CheckAgreeView.nextBtn2.addTarget(self, action: #selector(nextBtnClicked2), for: .touchUpInside)

    }
    
    @objc func tapDismissButton(){
        self.presentingViewController?.dismiss(animated: true)
    }

    @objc func agreeBtn1Clicked(){
        self.present(CheckPageServiceController(), animated: true)
    }
    
    @objc func agreeBtn2Clicked(){
        self.present(CheckPagePrivacyController(), animated: true)
    }
    
    @objc func agreeBtn3Clicked(){
        self.present(CheckPageMarketingController(), animated: true)
    }
    
    @objc func nextBtnClicked2(){
        
          // MARK: 체크여부 돌아오는지
        var allCheck : String = ""
        allCheck = UserDefaults.standard.string(forKey: "allcheck") ?? "0"
        var isChecked2 : String = ""
        isChecked2 = UserDefaults.standard.string(forKey: "check1") ?? "0"
        var isChecked3 : String = ""
        isChecked3 = UserDefaults.standard.string(forKey: "check2") ?? "0"
        var isChecked4 : String = ""
        isChecked4 = UserDefaults.standard.string(forKey: "check3") ?? "0"

        print("allCheck:\(allCheck), isChecked2:\(isChecked2), isChecked3:\(isChecked3), isChecked4:\(isChecked4)")
        
        var allChecked = Int(allCheck)
        var isCheck2 = Int(isChecked2)
        var isCheck3 = Int(isChecked3)
        var isCheck4 = Int(isChecked4)
        
        if allChecked == 1{
            self.present(RegisterationController(), animated: true)
        }
        else if isCheck2 == 1 && isCheck3 == 1 && isCheck4 == 1{
            self.present(RegisterationController(), animated: true)
        }
        else{
            print("체크안된게 있음")
        }

        
    }

}
