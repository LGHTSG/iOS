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
    
    let refreshControll : UIRefreshControl = UIRefreshControl()

    
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
    
    
    var userNameList = [String]()
    var userAssetList = [Int]()
    var userProfileList = [String]()
    
    
    func getRankList() {
        let url = "http://api.lghtsg.site:8090/event/demoday/user-ranking"
        let header: HTTPHeaders = ["Content-Type" : "application/json"]

        AF.request(url, method: .get, headers: header)
            .validate(statusCode: 200..<300)
            .responseDecodable(of : RankingModel.self) { response in
                switch response.result {
                case .success(let res):
                    do {
                        
                        for index in 0..<res.body.count {
                        var buffer : [Character] = []
                        buffer.append(contentsOf: res.body[index].userName)
                        let trans = String(buffer)
                        self.userNameList.append(trans)
                        self.userAssetList.append(res.body[index].userAsset)
                      //  self.userProfileList.append(res.body[index].profileImg)
                        }
                       
                        self.tableView.reloadData()
                       
                    } catch {
                        print("erorr in decode")
                    }
                case .failure(let err):
                    print(err.localizedDescription)
                }
            }
        }
    
    
    //MARK : refresh할 때 기능을 추가
    @objc func refreshFunction(){
        self.tableView.reloadData()
        self.userNameList.removeAll()
        self.userAssetList.removeAll()
        getRankList()
        configure()
        refreshControll.endRefreshing()
        tableView.reloadData()
    }
    
    
    //refreshControll에 기능을 추가해준다.
    func settingRefreshControl(){
        //getRankList()
        //당겨서 새로고침을 할 때, 해줄 함수적 기능을 넣어준다.
        refreshControll.addTarget(self, action: #selector(self.refreshFunction), for: .valueChanged)

    }
   
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        tableView.register(RankViewCell.self, forCellReuseIdentifier: RankViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        getRankList()
        
        
        tableView.refreshControl = refreshControll
        settingRefreshControl()
        refreshControll.addTarget(self, action: #selector(self.refreshFunction), for: .valueChanged)

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
            return userAssetList.count

        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RankViewCell.identifier, for: indexPath) as? RankViewCell else { return UITableViewCell() }
      
        
        cell.number.font = UIFont(name: "NanumSquareEB", size: 25.0)
        cell.userName.font = UIFont(name: "NanumSquareEB", size: 15.0)
        cell.userAsset.font = UIFont(name: "NanumSquareEB", size: 12.0)
        cell.transCount.font = UIFont(name: "NanumSquareEB", size: 12.0)
        cell.backgroundColor = .darkGray
        cell.userName.textColor = .white
        cell.userAsset.textColor = .lightGray
        cell.layer.cornerRadius = 15
        cell.layer.borderWidth = 5
        cell.layer.masksToBounds = true
        cell.number.text = String(indexPath.row + 1)
        cell.backgroundColor = .darkGray

        if 2 < indexPath.row && indexPath.row < 9 {
            cell.number.text! += "  "
        }
        
        if indexPath.row == 0 {
            cell.number.text = "🥇 "
            cell.number.font = UIFont(name: "NanumSquareB", size: 16)
            cell.backgroundColor = .systemGray2
            cell.userName.textColor = .black
            cell.userAsset.textColor = .systemPink
            cell.transCount.textColor = .darkGray
            //cell.iconImage.image = UIImage(named: "rank")
        }
        else if indexPath.row == 1 {
            cell.number.text = "🥈 "
            cell.number.font = UIFont(name: "NanumSquareB", size: 16)
            cell.backgroundColor = .systemGray2
            cell.userName.textColor = .black
            cell.userAsset.textColor = .systemPink
            cell.transCount.textColor = .darkGray
           // cell.iconImage.image = UIImage(named: "rank2")
        }
        else if indexPath.row == 2 {
            cell.number.text = "🥉 "
            cell.number.font = UIFont(name: "NanumSquareB", size: 16)
            cell.backgroundColor = .systemGray2
            cell.userName.textColor = .black
            cell.userAsset.textColor = .systemPink
            cell.transCount.textColor = .darkGray
           // cell.iconImage.image = UIImage(named: "rank3")
        }
        
        else if indexPath.row == 9 {
            cell.number.text = (cell.number.text ?? "") + ""
        }
        else {
            cell.number.text = (cell.number.text ?? "") + ""
        }
    

       // cell.iconImage.kf.setImage(with:  URL(string: estateDataLists[indexPath.row].iconImage))
        cell.userName.text = self.userNameList[indexPath.row]
        cell.userAsset.text = "[자산 : \(self.userAssetList[indexPath.row].withCommas())원]"
       // cell.iconImage.kf.setImage(with:  URL(string: userProfileList[indexPath.row]))
        cell.selectionStyle = .none
        
        return cell
            
        
    }
    
}

