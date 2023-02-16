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
        vc.estateDataLists = AreaDataLists
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
        vc.stockDataLists = stockDataLists
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
        vc.resellDataLists = resellDataLists
        vc.label.font = UIFont(name: "NanumSquareEB", size: 20.0)
          self.navigationController?.pushViewController(vc, animated: true)
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
        setupTableView()
        getResellList()
        view.backgroundColor = .black
        
    }
    
    //MARK: - EstateApi
    var AreaDataLists = [EstatePriceDetailModel.EstateBody]()
    func getAreaList() {
            let topviewmodel = topViewModel()
        topviewmodel.getAreaList(){
            data in
            self.AreaDataLists = data
            self.tableView1.delegate = self
            self.tableView1.dataSource = self
            self.tableView1.reloadData()
            self.configure()
            
        }
    }
    
    //MARK: - Stockapi
    var stockDataLists = [asset.body]()
    func getStockList(){
        let stockModel = TableCellModel()
        stockModel.requestTableCellModel(segmentIndex: 2){
            data in
            self.stockDataLists = data
            self.tableView2.delegate = self
            self.tableView2.dataSource = self
            self.tableView2.reloadData()
           
        }
    }
    //MARK: - Resellapi
    var resellDataLists = [resellData.body]()
    func getResellList() {
        let resellmodel = TableCellModel()
        resellmodel.requestResellModel(segmentIndex: 0){
            data in
            self.resellDataLists = data
            self.tableView3.delegate = self
            self.tableView3.dataSource = self
            self.tableView3.reloadData()
            
        }
    }
    //MARK: - TableView
    
    func setupTableView(){
        tableView1.register(TopViewCell.self, forCellReuseIdentifier: TopViewCell.identifier)
        tableView2.register(TopViewCell.self, forCellReuseIdentifier: TopViewCell.identifier)
        tableView3.register(TopViewCell.self, forCellReuseIdentifier: TopViewCell.identifier)
    }
    
    //cell 높이조절
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 55
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TopViewCell.identifier, for: indexPath) as? TopViewCell else { return UITableViewCell() }
        
        cell.number.font = UIFont(name: "NanumSquareB", size: 15.0)
        cell.title.font = UIFont(name: "NanumSquareEB", size: 14.0)
        cell.price.font = UIFont(name: "NanumSquareB", size: 12.0)
        cell.percentage.font = UIFont(name: "NanumSquareEB", size: 12.0)
        cell.period.font = UIFont(name: "NanumSquareB", size: 12.0)
        
        //let rurl = URL(string: riconList[indexPath.row])



        if tableView == tableView1{
            cell.number.text = String(indexPath.row + 1)
            cell.iconImage.kf.setImage(with:  URL(string: AreaDataLists[indexPath.row].iconImage))
            cell.title.text = AreaDataLists[indexPath.row].name
            cell.percentage.text = "\(AreaDataLists[indexPath.row].rateOfChange)%"
            cell.price.text = String(AreaDataLists[indexPath.row].price.withCommas())+"원/m2"
            
            
            
            if AreaDataLists[indexPath.row].rateOfChange > 0 {
                cell.percentage.textColor = .systemRed
            }else{
                cell.percentage.textColor = .systemBlue
            }
            cell.period.text = AreaDataLists[indexPath.row].rateCalDateDiff
            cell.selectionStyle = .none
            return cell
        }
        else if tableView == tableView2{
            cell.number.text = String(indexPath.row + 1)
            cell.iconImage.kf.setImage(with:  URL(string: stockDataLists[indexPath.row].iconImage))
            cell.title.text = stockDataLists[indexPath.row].name
            cell.percentage.text = "\(stockDataLists[indexPath.row].rateOfChange)%"
            cell.price.text = String(stockDataLists[indexPath.row].price.withCommas())+"원"
            
            
            
            
            if stockDataLists[indexPath.row].rateOfChange > 0 {
                cell.percentage.textColor = .systemRed
            }else{
                cell.percentage.textColor = .systemBlue
            }
            cell.period.text = stockDataLists[indexPath.row].rateCalDateDiff
            cell.selectionStyle = .none
            return cell
            
        }
        else if tableView == tableView3{
            cell.number.text = String(indexPath.row + 1)
            cell.iconImage.kf.setImage(with:  URL(string: resellDataLists[indexPath.row].imageUrl))
            cell.title.text = resellDataLists[indexPath.row].name
            cell.percentage.text = "\(resellDataLists[indexPath.row].rateOfChange)%"
            cell.price.text = String(resellDataLists[indexPath.row].price.withCommas())+"원"
            
            
            
            if resellDataLists[indexPath.row].rateOfChange > 0 {
                cell.percentage.textColor = .systemRed
            }else{
                cell.percentage.textColor = .systemBlue
            }
            cell.period.text = resellDataLists[indexPath.row].rateCalDateDiff
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
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
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
            $0.top.equalTo(topViewButton1.snp.bottom).offset(10)
            $0.bottom.equalTo(topViewButton1.snp.bottom).offset(120)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        topViewButton2.snp.makeConstraints{
            $0.top.equalTo(tableView1.snp.bottom).offset(40)
            $0.bottom.equalTo(tableView1.snp.bottom).offset(60)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        topLabel2.snp.makeConstraints{
            $0.leading.equalTo(topViewButton2.snp.leading).offset(1)
            $0.top.equalTo(topViewButton2.snp.top).offset(5)
        }
        
        tableView2.snp.makeConstraints{
            $0.top.equalTo(topViewButton2.snp.bottom).offset(20)
            $0.bottom.equalTo(topViewButton2.snp.bottom).offset(120)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }

        topViewButton3.snp.makeConstraints{
            $0.top.equalTo(tableView2.snp.bottom).offset(40)
            $0.bottom.equalTo(tableView2.snp.bottom).offset(60)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        topLabel3.snp.makeConstraints{
            $0.leading.equalTo(topViewButton2.snp.leading).offset(1)
            $0.top.equalTo(topViewButton3.snp.top).offset(5)
        }
        
        tableView3.snp.makeConstraints{
            $0.top.equalTo(topViewButton3.snp.bottom).offset(20)
            $0.bottom.equalTo(topViewButton3.snp.bottom).offset(120)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
    }
}
