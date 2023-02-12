//
//  RankViewController.swift
//  LGHTSG
//
//  Created by HA on 2023/02/10.
//

import UIKit
import SnapKit
import Alamofire
import Kingfisher

class RankViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    //MARK: - Properties
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.text = "🏆 Ranking TOP 10 🏆"
        label.font = UIFont(name: "NanumSquareEB", size: 20.0)
        label.textColor = .white
        return label
    }()
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        return table
    }()

    //MARK: - Api
    /*
    var userNameList = [Character]()
    var userAssetList = [Int]()
    var transCount = [Int]()
    
    func getAreaList() {
        let url = "http://api.lghtsg.site:8090/event/demoday/user-ranking"
        let header: HTTPHeaders = ["Content-Type" : "application/json"]
        AF.request(url, method: .get, headers: header)
            .validate(statusCode: 200..<300)
            .responseData { response in
                switch response.result {
                case .success(let res):
                    let decoder = JSONDecoder()
                    do {
                        let data = try decoder.decode(RankingModel.self, from: res)
                        self.userNameList.append(contentsOf: data.body[0].userName)
                        print(self.userNameList)

                        
                    } catch {
                        print("erorr in decode")
                    }
                case .failure(let err):
                    print(err.localizedDescription)
                }
            }
        }
    
    func getRankList() {
        let url = "http://api.lghtsg.site:8090/event/demoday/user-ranking"
        let header: HTTPHeaders = ["Content-Type" : "application/json"]
        AF.request(url, method: .get, headers: header)
            .validate(statusCode: 200..<300)
            .responseDecodable(of : RankingModel.self) { response in
                switch response.result {
                case .success(let res):
                    do {
                        self.userNameList.append(contentsOf: res.body[0].userName)
                        print(self.userNameList)
                    } catch {
                        print("erorr in decode")
                    }
                case .failure(let err):
                    print(err.localizedDescription)
                }
            }
        }*/
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        tableView.register(RankViewCell.self, forCellReuseIdentifier: RankViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
       // getAreaList()
    }
    //MARK: - Configure
    func configure(){
        view.backgroundColor = .black
        [label,tableView]
          .forEach {view.addSubview($0)}
        
        label.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.height.equalTo(40)
            $0.centerX.equalToSuperview()
          
        }
        tableView.snp.makeConstraints{
            $0.top.equalTo(label.snp.bottom).offset(10)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-15)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
    }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
                return 65
        }
    
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 10

        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RankViewCell.identifier, for: indexPath) as? RankViewCell else { return UITableViewCell() }
      
        cell.number.font = UIFont(name: "NanumSquareB", size: 25.0)
        cell.userName.font = UIFont(name: "NanumSquareEB", size: 15.0)
        cell.userAsset.font = UIFont(name: "NanumSquareEB", size: 12.0)
        
        cell.transCount.font = UIFont(name: "NanumSquareB", size: 12.0)
        cell.backgroundColor = .darkGray
        cell.layer.cornerRadius = 15
        cell.layer.borderWidth = 5
        cell.layer.masksToBounds = true
        cell.number.text = String(indexPath.row + 1)
        
        if cell.number.text == "1" {
            cell.number.text = "🥇 "
        }
        else if cell.number.text == "2" {
            cell.number.text = "🥈 "
        }
        else if cell.number.text == "3" {
            cell.number.text = "🥉 "
        }
        else if cell.number.text == "10" {
            cell.number.text = (cell.number.text ?? "") + ""
        }
        else {
            cell.number.text = (cell.number.text ?? "") + "  "
        }
        
        if indexPath.row < 3 {
            cell.backgroundColor = .systemGray3
            cell.userName.textColor = .black
            cell.userAsset.textColor = .systemPink
            cell.transCount.textColor = .darkGray
        }else{
            cell.backgroundColor = .darkGray
        }
        
        /*
        if cell.transCount < 6 {
            cell.transCount.textColor = .systemPink
        }
         */
        
        /*
        if cell.number.text == "1" {
            cell.number.textColor = .yellow
        }else if cell.number.text == "2"{
            cell.number.textColor = .systemGray3
        }else if cell.number.text == "3"{
            cell.number.textColor = .brown

        }else{
            cell.number.textColor = .white
        }
         */
                    
       // cell.iconImage.kf.setImage(with:  URL(string: estateDataLists[indexPath.row].iconImage))
        cell.userName.text = "홍길동"
        cell.userAsset.text = "자산 : 2322900"
        cell.transCount.text = "남은횟수 : 20회"
        cell.selectionStyle = .none
        
        return cell
            
        
    }
    
}
