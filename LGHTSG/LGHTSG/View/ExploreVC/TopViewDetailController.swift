//
//  TopViewDetailController.swift
//  LGHTSG
//
//  Created by HA on 2023/02/04.
//

import UIKit
import SnapKit
import Alamofire

class TopViewDetailController: UIViewController{
    
    
    //MARK: - Properties
    lazy var label: UILabel = {
        let label = UILabel()
        label.text = "hellllloo"
        label.textColor = .white
        return label
    }()
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        return table
    }()

    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        
    }
  
    //MARK: - Configure
    
    func configure(){
        view.backgroundColor = .black
        [label]
          .forEach {view.addSubview($0)}
        
        label.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(60)
            $0.height.equalTo(40)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        /*tableView.snp.makeConstraints{
            $0.top.equalTo(label.snp.bottom).offset(10)
            $0.height.equalTo(110)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }*/
    }
    
   /* func setupTableView() {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            <#code#>
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            <#code#>
        }
        
    }*/
}
