//
//  TopViewController.swift
//  LGHTSG
//
//  Created by HA on 2023/01/30.
//

import UIKit
import SnapKit
import Alamofire
import Kingfisher


class TopViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    //MARK: - TopTitle
    
    //topview 1,2,3 addTarget 하기, 이미지view 원
    private lazy var topViewButton1: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .black
        btn.addSubview(topLabel1)
        btn.addSubview(chevron1)
        btn.addTarget(self, action: #selector(didTaptopViewButton1), for: .touchUpInside)

        return btn
    }()

    @objc func didTaptopViewButton1() {
        let vc = TopViewDetailController()
        vc.label.text = "#강남구 집값 Top 10"
        vc.label.font = UIFont(name: "NanumSquareEB", size: 20.0)
        
        self.navigationController?.pushViewController(vc, animated: true)
        
        print("1")

    }
    private lazy var topViewButton2: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .black
        btn.addSubview(topLabel2)
        btn.addSubview(chevron2)
        btn.addTarget(self, action: #selector(didTaptopViewButton2), for: .touchUpInside)
        return btn
    }()
    @objc func didTaptopViewButton2() {
        let vc = TopViewDetailController()
        vc.label.text = "#최근 가장 HOT한 주식"
        vc.label.font = UIFont(name: "NanumSquareEB", size: 20.0)
          self.navigationController?.pushViewController(vc, animated: true)
        print("2")

    }
    private lazy var topViewButton3: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .black
        btn.addSubview(topLabel3)
        btn.addSubview(chevron3)
        btn.addTarget(self, action: #selector(didTaptopViewButton3), for: .touchUpInside)
        return btn
    }()
    @objc func didTaptopViewButton3() {
        let vc = TopViewDetailController()
        vc.label.text = "#어제 급등한 리셀"
        vc.label.font = UIFont(name: "NanumSquareEB", size: 20.0)
          self.navigationController?.pushViewController(vc, animated: true)
       print("3")
    }
    private lazy var topLabel1: UILabel = {
        let label = UILabel()
        label.text = "#강남구 집값 Top 10"
        label.font = UIFont(name: "NanumSquareEB", size: 20.0)
        label.textColor = .white
        return label
    }()
    
    private lazy var topLabel2: UILabel = {
        let label = UILabel()
        label.text = "#최근 가장 HOT한 주식"
        label.font = UIFont(name: "NanumSquareEB", size: 20.0)
        label.textColor = .white
        return label
    }()
    
    private lazy var topLabel3: UILabel = {
        let label = UILabel()
        label.text = "#어제 급등한 리셀"
        label.font = UIFont(name: "NanumSquareEB", size: 20.0)
        label.textColor = .white
        return label
    }()
    
    private lazy var chevron1: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(systemName: "chevron.right")!
        imageView.image = image
        imageView.tintColor = .white
        imageView.setContentHuggingPriority(.required, for: .horizontal)
        imageView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return imageView
    }()
    
    private lazy var chevron2: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(systemName: "chevron.right")!
        imageView.image = image
        imageView.tintColor = .white
                imageView.setContentHuggingPriority(.required, for: .horizontal)
                imageView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return imageView
    }()
    
    private lazy var chevron3: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(systemName: "chevron.right")!
        imageView.image = image
        imageView.tintColor = .white
        imageView.setContentHuggingPriority(.required, for: .horizontal)
        imageView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return imageView
    }()

    
    //MARK: - tableView
    
    
    private lazy var tableView1: UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        return table
    }()
    
    private lazy var tableView2: UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        return table
    }()
    
    private lazy var tableView3: UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        return table
    }()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAreaList()
        getStockList()
        getResellList()
        configure()
        setupTableView()

    }
    
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
                        for index in 0..<2 {
                            self.nameLists.append(res.body[index].name)
                            self.rateCalDateDiff.append(res.body[index].rateCalDateDiff)
                            self.rateOfChange.append(res.body[index].rateOfChange)
                            self.price.append(res.body[index].price)
                            self.iconList.append(res.body[index].iconImage)
                        }
                        self.tableView1.reloadData()
                        self.tableView2.reloadData()
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
                        for index in 0..<2 {
                            self.snameLists.append(res.body[index].name)
                            self.srateCalDateDiff.append(res.body[index].rateCalDateDiff)
                            self.srateOfChange.append(res.body[index].rateOfChange)
                            self.sprice.append(res.body[index].price)
                            self.siconList.append(res.body[index].iconImage)
                        }
                        self.tableView2.reloadData()
                        self.tableView3.reloadData() //왜지..?

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
                        for index in 0..<2 {
                            self.rnameLists.append(res.body[index].name)
                            self.rrateCalDateDiff.append(res.body[index].rateCalDateDiff)
                            self.rrateOfChange.append(res.body[index].rateOfChange)
                            self.rprice.append(res.body[index].price)
                          //  self.riconList.append(res.body[index].imageURL)
                        }
                        
                        self.tableView2.reloadData()
                        self.tableView3.reloadData()

                    } catch {
                        print("erorr in decode")
                    }
                case .failure(let err):
                    print(err.localizedDescription)
                }
            }
        }
    //MARK: - TableView
    
    func setupTableView(){
        tableView1.delegate = self
        tableView1.dataSource = self
        tableView1.register(TopViewCell.self, forCellReuseIdentifier: TopViewCell.identifier)
        tableView2.delegate = self
        tableView2.dataSource = self
        tableView2.register(TopViewCell.self, forCellReuseIdentifier: TopViewCell.identifier)
        tableView3.delegate = self
        tableView3.dataSource = self
        tableView3.register(TopViewCell.self, forCellReuseIdentifier: TopViewCell.identifier)
    }
    
    //cell 높이조절
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 45
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



        if tableView == tableView1{
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
        }
        else if tableView == tableView2{
           
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
            
        }
        else if tableView == tableView3{
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
        }
        else { return UITableViewCell() }

    }
    //MARK: - Configure
    
    func configure(){
        view.backgroundColor = .black
        
        [topViewButton1, topViewButton2, topViewButton3, topLabel1, topLabel2, topLabel3, tableView1, tableView2, tableView3, chevron1, chevron2, chevron3]
          .forEach {view.addSubview($0)}
        
        topViewButton1.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.height.equalTo(40)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        topLabel1.snp.makeConstraints{
            $0.leading.equalTo(topViewButton1.snp.leading).offset(1)
            $0.top.equalTo(topViewButton1.snp.top).offset(5)
        }
        
        chevron1.snp.makeConstraints{
            $0.trailing.equalTo(topViewButton1.snp.trailing).offset(-4)

            $0.top.equalTo(topViewButton1.snp.top).offset(5)

        }
        chevron2.snp.makeConstraints{
            $0.trailing.equalTo(topViewButton2.snp.trailing).offset(-4)
            $0.top.equalTo(topViewButton2.snp.top).offset(5)

        }
        chevron3.snp.makeConstraints{
            $0.trailing.equalTo(topViewButton3.snp.trailing).offset(-4)
            $0.top.equalTo(topViewButton3.snp.top).offset(5)

        }
        
        tableView1.snp.makeConstraints{
            $0.top.equalTo(topViewButton1.snp.bottom).offset(5)
            $0.height.equalTo(110)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        topViewButton2.snp.makeConstraints{
            $0.top.equalTo(tableView1.snp.bottom).offset(30)
            $0.bottom.equalTo(tableView1.snp.bottom).offset(60)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        topLabel2.snp.makeConstraints{
            $0.leading.equalTo(topViewButton2.snp.leading).offset(1)
            $0.top.equalTo(topViewButton2.snp.top).offset(5)
        }
        
        tableView2.snp.makeConstraints{
            $0.top.equalTo(topViewButton2.snp.bottom).offset(10)
            $0.bottom.equalTo(topViewButton2.snp.bottom).offset(120)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }

        topViewButton3.snp.makeConstraints{
            $0.top.equalTo(tableView2.snp.bottom).offset(30)
            $0.bottom.equalTo(tableView2.snp.bottom).offset(60)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        topLabel3.snp.makeConstraints{
            $0.leading.equalTo(topViewButton2.snp.leading).offset(1)
            $0.top.equalTo(topViewButton3.snp.top).offset(5)
        }
        
        tableView3.snp.makeConstraints{
            $0.top.equalTo(topViewButton3.snp.bottom).offset(10)
            $0.bottom.equalTo(topViewButton3.snp.bottom).offset(120)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
    }
}
