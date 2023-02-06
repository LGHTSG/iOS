//
//  TopViewDetailController.swift
//  LGHTSG
//
//  Created by HA on 2023/02/04.
//

import UIKit
import SnapKit
import Alamofire

class TopViewDetailController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    //MARK: - Properties
    lazy var label: UILabel = {
        let label = UILabel()
        label.text = "hellllloo"
        label.textColor = .white
        return label
    }()
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        return table
    }()

    //MARK: - EstateApi
    
    var nameLists = [String]()
    var rateOfChange = [Double]()
    var rateCalDateDiff = [String]()
    var price = [Int]()
    var iconList = [String]()
    func getAreaList() {
        let urlSTR = "http://api.lghtsg.site:8090/realestates?order=descending&sort=price&area=서울특별시+강남구"
        let encodedStr = urlSTR.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = URL(string: encodedStr)!
        let header: HTTPHeaders = ["Content-Type" : "application/json"]
        AF.request(url, method: .get, headers: header)
            .validate(statusCode: 200..<300)
            .responseDecodable(of : EstatePriceDetailModel.self) { response in
                switch response.result {
                case .success(let res):
                    do {
                        for index in 0..<10 {
                            self.nameLists.append(res.body[index].name)
                            self.rateCalDateDiff.append(res.body[index].rateCalDateDiff)
                            self.rateOfChange.append(res.body[index].rateOfChange)
                            self.price.append(res.body[index].price)
                            self.iconList.append(res.body[index].iconImage)
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
    
    //MARK: - Stockapi
    var snameLists = [String]()
    var srateOfChange = [Double]()
    var srateCalDateDiff = [String]()
    var sprice = [Int]()
    var siconList = [String]()

    func getStockList() {
        let urlSTR = "http://api.lghtsg.site:8090/stocks?sort=trading-volume&order=descending"
        let encodedStr = urlSTR.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = URL(string: encodedStr)!
        let header: HTTPHeaders = ["Content-Type" : "application/json"]
        AF.request(url, method: .get, headers: header)
            .validate(statusCode: 200..<300)
            .responseDecodable(of : StockVolumeModel.self) { response in
                switch response.result {
                case .success(let res):
                    do {
                        for index in 0..<10 {
                            self.snameLists.append(res.body[index].name)
                            self.srateCalDateDiff.append(res.body[index].rateCalDateDiff)
                            self.srateOfChange.append(res.body[index].rateOfChange)
                            self.sprice.append(res.body[index].price)
                            self.siconList.append(res.body[index].iconImage)
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
    
    //MARK: - Resellapi
    var rnameLists = [String]()
    var rrateOfChange = [Double]()
    var rrateCalDateDiff = [String]()
    var rprice = [Int]()
    var riconList = [String]()

    func getResellList() {
        let url = "http://api.lghtsg.site:8090/resells?order=descending&sort=fluctuation"
        let header: HTTPHeaders = ["Content-Type" : "application/json"]
        AF.request(url, method: .get, headers: header)
            .validate(statusCode: 200..<300)
            .responseDecodable(of : ResellFluctuationModel.self) { response in
                switch response.result {
                case .success(let res):
                    do {
                        for index in 0..<10 {
                            self.rnameLists.append(res.body[index].name)
                            self.rrateCalDateDiff.append(res.body[index].rateCalDateDiff)
                            self.rrateOfChange.append(res.body[index].rateOfChange)
                            self.rprice.append(res.body[index].price)
                          //  self.riconList.append(res.body[index].imageURL)
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
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        getAreaList()
        getStockList()
        getResellList()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TopViewCell.self, forCellReuseIdentifier: TopViewCell.identifier)
    }
  
    //MARK: - Configure
    
    func configure(){
        view.backgroundColor = .black
        [label,tableView]
          .forEach {view.addSubview($0)}
        
        label.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
            $0.height.equalTo(40)
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview()
        }
        tableView.snp.makeConstraints{
            $0.top.equalTo(label.snp.bottom).offset(10)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-15)
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview()
        }
    }
    
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
                return 55
        }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return nameLists.count

        }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TopViewCell.identifier, for: indexPath) as? TopViewCell else { return UITableViewCell() }
        cell.number.font = UIFont(name: "NanumSquareB", size: 15.0)
        cell.title.font = UIFont(name: "NanumSquareEB", size: 15.0)
        cell.price.font = UIFont(name: "NanumSquareB", size: 12.0)
        cell.percentage.font = UIFont(name: "NanumSquareB", size: 12.0)
        cell.period.font = UIFont(name: "NanumSquareB", size: 12.0)
        
        let url = URL(string: iconList[indexPath.row])
        let surl = URL(string: siconList[indexPath.row])
        //let rurl = URL(string: riconList[indexPath.row])
        
        if label.text! == "#강남구 집값 Top 10"{
            cell.number.text = String(indexPath.row + 1)
            cell.iconImage.kf.setImage(with: url)
            cell.title.text = self.nameLists[indexPath.row]
            cell.price.text = "\(self.price[indexPath.row])원/m"
            cell.percentage.text = "\(self.rateOfChange[indexPath.row])%"
            if self.rateOfChange[indexPath.row] > 0 {
                cell.percentage.textColor = .systemRed
            }else{
                cell.percentage.textColor = .systemBlue
            }
            cell.period.text = self.rateCalDateDiff[indexPath.row]
            cell.selectionStyle = .none
            return cell
            
        }else if label.text! == "#최근 가장 HOT한 주식" {
            cell.number.text = String(indexPath.row + 1)
            cell.iconImage.kf.setImage(with: surl)
            cell.title.text = self.snameLists[indexPath.row]
            cell.price.text = "\(self.sprice[indexPath.row])원"
            cell.percentage.text = "\(self.srateOfChange[indexPath.row])%"
            if self.srateOfChange[indexPath.row] > 0 {
                cell.percentage.textColor = .systemRed
            }else{
                cell.percentage.textColor = .systemBlue
            }
            cell.period.text = self.srateCalDateDiff[indexPath.row]
            cell.selectionStyle = .none
            return cell
            
        }else if label.text! == "#어제 급등한 리셀"{
            cell.number.text = String(indexPath.row + 1)
            //cell.iconImage.kf.setImage(with: rurl)
            cell.title.text = self.rnameLists[indexPath.row]
            cell.price.text = "\(self.rprice[indexPath.row])원"
            cell.percentage.text = "\(self.rrateOfChange[indexPath.row])%"
            if self.rrateOfChange[indexPath.row] > 0 {
                cell.percentage.textColor = .systemRed
            }else{
                cell.percentage.textColor = .systemBlue
            }
            cell.period.text = self.rrateCalDateDiff[indexPath.row]
            cell.selectionStyle = .none
            return cell
        }else{
            return UITableViewCell()
        }
        
    }
    
}
