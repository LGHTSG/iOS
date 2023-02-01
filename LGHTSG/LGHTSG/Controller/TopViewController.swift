//
//  TopViewController.swift
//  LGHTSG
//
//  Created by HA on 2023/01/30.
//

import UIKit
import SnapKit
import Alamofire



class TopViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    //MARK: - TopTitle
    
    //topview 1,2,3 addTarget 하기, 이미지view 원
    private lazy var topView1: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.addSubview(topLabel1)
        view.addSubview(chevron1)
        return view
    }()
    
    private lazy var topView2: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.addSubview(topLabel2)
        view.addSubview(chevron2)
        return view
    }()
    
    private lazy var topView3: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.addSubview(topLabel3)
        view.addSubview(chevron3)
        return view
    }()
    
    private lazy var topLabel1: UILabel = {
        let label = UILabel()
        label.text = "#강남구 집값 Top 10"
        label.textColor = .white
        return label
    }()
    
    private lazy var topLabel2: UILabel = {
        let label = UILabel()
        label.text = "#23년 새롭게 바귄 시총 순위"
        label.textColor = .white
        return label
    }()
    
    private lazy var topLabel3: UILabel = {
        let label = UILabel()
        label.text = "#어제 급등한 리셀"
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
                imageView.snp.makeConstraints { (make) in
                    make.width.equalTo(40)
                }
        return imageView
    }()
    
    private lazy var chevron2: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(systemName: "chevron.right")!
        imageView.image = image
        imageView.tintColor = .white
                imageView.setContentHuggingPriority(.required, for: .horizontal)
                imageView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
                imageView.snp.makeConstraints { (make) in
                    make.width.equalTo(40)
                }
        return imageView
    }()
    
    private lazy var chevron3: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(systemName: "chevron.right")!
        imageView.image = image
        imageView.tintColor = .white
                imageView.setContentHuggingPriority(.required, for: .horizontal)
                imageView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
                imageView.snp.makeConstraints { (make) in
                    make.width.equalTo(40)
                }
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
        setupTableView()
        configure()
    }
    
    //MARK: - network
    
    var idxList = [Int]()
    var nameLists = [String]()
    var rateOfChange = [Double]()
    var rateCalDateDiff = [String]()
    var price = [Int]()
    
    func getAreaList() {
        let url = "http://api.lghtsg.site:8090/realestates/area-relation-list"
        let header: HTTPHeaders = ["Content-Type" : "application/json"]
        AF.request(url, method: .get, headers: header)
            .validate(statusCode: 200..<300)
            .responseData { response in
                switch response.result {
                case .success(let res):
                    let decoder = JSONDecoder()
                    do {
                        let data = try decoder.decode(EstateModel.self, from: res)
                        self.nameLists.append(data.body.name)
                        self.idxList.append(data.body.idx)
                        self.rateOfChange.append(data.body.rateOfChange)
                        self.rateCalDateDiff.append(data.body.rateCalDateDiff)
                        self.price.append(data.body.price)
                        self.tableView1.reloadData()
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
            return 55
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tableView1{
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TopViewCell.identifier, for: indexPath) as? TopViewCell else { return UITableViewCell() }
            
            cell.number.text = "1"
            cell.title.text = "서울시"
            cell.price.text = "22,303,921 원/m"
            cell.percentage.text = "+ 3.0%"
            cell.period.text = "3달 전 대비"
            cell.selectionStyle = .none

            return cell
        }
        
        else if tableView == tableView2{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TopViewCell.identifier, for: indexPath) as? TopViewCell else { return UITableViewCell() }
            cell.number.text = "1"
            cell.title.text = "서울시"
            cell.price.text = "22,303,921 원/m"
            cell.percentage.text = "+ 3.0%"
            cell.period.text = "3달 전 대비"
            cell.selectionStyle = .none

            return cell
            }else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TopViewCell.identifier, for: indexPath) as? TopViewCell else { return UITableViewCell() }
                cell.number.text = "1"
                cell.title.text = "서울시"
                cell.price.text = "22,303,921 원/m"
                cell.percentage.text = "+ 3.0%"
                cell.period.text = "3달 전 대비"
                cell.selectionStyle = .none

                return cell
        }
    }
    //MARK: - Configure
    
    func configure(){
        view.backgroundColor = .black
        
        [topView1, topView2, topView3, topLabel1, topLabel2, topLabel3, tableView1, tableView2, tableView3, chevron1, chevron2, chevron3]
          .forEach {view.addSubview($0)}
        
        topView1.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(150)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-580)
            $0.leading.equalToSuperview().inset(25)
            $0.trailing.equalToSuperview().inset(25)
        }
        
        topLabel1.snp.makeConstraints{
            $0.leading.equalTo(topView1.snp.leading).offset(1)
            $0.top.equalTo(topView1.snp.top).offset(5)
        }
        
        chevron1.snp.makeConstraints{
            $0.trailing.equalTo(topView1.snp.trailing).offset(-4)
            $0.leading.equalTo(topView1.snp.trailing).offset(9)
            $0.top.equalTo(topView1.snp.top).offset(5)

        }
        chevron2.snp.makeConstraints{
            $0.trailing.equalTo(topView2.snp.trailing).offset(-4)
            $0.leading.equalTo(topView2.snp.trailing).offset(9)
            $0.top.equalTo(topView2.snp.top).offset(5)

        }
        chevron3.snp.makeConstraints{
            $0.trailing.equalTo(topView3.snp.trailing).offset(-4)
            $0.leading.equalTo(topView3.snp.trailing).offset(9)
            $0.top.equalTo(topView3.snp.top).offset(5)

        }
        
        tableView1.snp.makeConstraints{
            $0.top.equalTo(topView1.snp.bottom).offset(5)
            $0.bottom.equalTo(topView1.snp.bottom).offset(120)
            $0.leading.equalToSuperview().inset(25)
            $0.trailing.equalToSuperview().inset(25)
        }
        
        topView2.snp.makeConstraints{
            $0.top.equalTo(tableView1.snp.bottom).offset(30)
            $0.bottom.equalTo(tableView1.snp.bottom).offset(60)
            $0.leading.equalToSuperview().inset(25)
            $0.trailing.equalToSuperview().inset(25)
        }
        
        topLabel2.snp.makeConstraints{
            $0.leading.equalTo(topView2.snp.leading).offset(1)
            $0.top.equalTo(topView2.snp.top).offset(5)
        }
        
        tableView2.snp.makeConstraints{
            $0.top.equalTo(topView2.snp.bottom).offset(5)
            $0.bottom.equalTo(topView2.snp.bottom).offset(120)
            $0.leading.equalToSuperview().inset(25)
            $0.trailing.equalToSuperview().inset(25)
        }

        topView3.snp.makeConstraints{
            $0.top.equalTo(tableView2.snp.bottom).offset(30)
            $0.bottom.equalTo(tableView2.snp.bottom).offset(60)
            $0.leading.equalToSuperview().inset(25)
            $0.trailing.equalToSuperview().inset(25)
        }
        
        topLabel3.snp.makeConstraints{
            $0.leading.equalTo(topView2.snp.leading).offset(1)
            $0.top.equalTo(topView3.snp.top).offset(5)
        }
        
        tableView3.snp.makeConstraints{
            $0.top.equalTo(topView3.snp.bottom).offset(5)
            $0.bottom.equalTo(topView3.snp.bottom).offset(120)
            $0.leading.equalToSuperview().inset(25)
            $0.trailing.equalToSuperview().inset(25)
        }

    }

    
    
}
