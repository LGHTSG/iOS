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
        
        view.addSubview(JoinSuccessView)
        JoinSuccessView.translatesAutoresizingMaskIntoConstraints = false
        JoinSuccessView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        JoinSuccessView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        JoinSuccessView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        JoinSuccessView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true

    }


}