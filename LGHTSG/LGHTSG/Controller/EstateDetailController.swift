//
//  StockController.swift
//  LGHTSG
//
//  Created by HA on 2023/01/17.
//

import UIKit
import SwiftUI
import SnapKit
import DropDown

class EstateDetailController: UIViewController{
    
    //MARK: - Button
    private lazy var sellButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("판매", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        btn.backgroundColor = .black
        btn.layer.cornerRadius = 5
        btn.layer.borderWidth = 1
        return btn
    }()
    
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    
    func configure(){
        view.addSubview(sellButton)
        
        sellButton.snp.makeConstraints{
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-97)
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().inset(33)
            $0.width.equalTo(324)
            $0.height.equalTo(48)
        }
    }
    
}

//MARK: - SwiftUI

struct MysViewController_PreViews: PreviewProvider {
    static var previews: some View {
        EstateDetailController().toPreview() //원하는 VC를 여기다 입력하면 된다.
    }
}
extension UIViewController {
    private struct Preview: UIViewControllerRepresentable {
        let viewController: UIViewController

    func makeUIViewController(context: Context) -> UIViewController {
        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }
}

    func tosPreview() -> some View {
        Preview(viewController: self)
    }
}
