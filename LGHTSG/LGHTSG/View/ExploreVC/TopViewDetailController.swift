//
//  TopViewDetailController.swift
//  LGHTSG
//
//  Created by HA on 2023/02/04.
//

import UIKit
import SnapKit
import Alamofire
import Kingfisher

class TopViewDetailController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    //MARK: - Properties
    lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        return table
    }()

    //MARK: - EstateApi
    var estateDataLists = [EstatePriceDetailModel.EstateBody]()
    //MARK: - Stockapi
    var stockDataLists = [asset.body]()
    //MARK: - Resellapi
    var resellDataLists = [resellData.body]()
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        tableView.register(TopViewCell.self, forCellReuseIdentifier: TopViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
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
            return 10

        }
        
    // 클릭했을때
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if label.text! == "#강남구 집값 Top 10"{
            let estateChartVc = EstateChartViewController()
            estateChartVc.idx = estateDataLists[indexPath.row].idx
            estateChartVc.nameText = estateDataLists[indexPath.row].name
            estateChartVc.changeDateText = estateDataLists[indexPath.row].rateCalDateDiff
            estateChartVc.pricePercentText = "\(estateDataLists[indexPath.row].rateOfChange)%"
            self.navigationController?.pushViewController(estateChartVc, animated: true)
        }
        else if label.text! == "#최근 가장 HOT한 주식" {
            let stockChartVC = StockChartViewController()
            stockChartVC.nameText =  stockDataLists[indexPath.row].name
            stockChartVC.changeDateText = stockDataLists[indexPath.row].rateCalDateDiff
            stockChartVC.pricePercentText = "\(stockDataLists[indexPath.row].rateOfChange)%"
            stockChartVC.idx = stockDataLists[indexPath.row].idx
            self.navigationController?.pushViewController(stockChartVC, animated: true)
        }
        else if label.text! == "#어제 급등한 리셀"{}
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TopViewCell.identifier, for: indexPath) as? TopViewCell else { return UITableViewCell() }
        cell.number.font = UIFont(name: "NanumSquareB", size: 15.0)
        cell.title.font = UIFont(name: "NanumSquareEB", size: 15.0)
        cell.price.font = UIFont(name: "NanumSquareB", size: 12.0)
        cell.percentage.font = UIFont(name: "NanumSquareEB", size: 12.0)
        cell.period.font = UIFont(name: "NanumSquareB", size: 12.0)
        if label.text! == "#강남구 집값 Top 10"{
            cell.number.text = String(indexPath.row + 1)
            cell.iconImage.kf.setImage(with:  URL(string: estateDataLists[indexPath.row].iconImage))
            cell.title.text = self.estateDataLists[indexPath.row].name
            cell.price.text = "\(self.estateDataLists[indexPath.row].price)원/m"
            cell.percentage.text = "\(self.estateDataLists[indexPath.row].rateOfChange)%"
            if estateDataLists[indexPath.row].rateOfChange > 0 {
                cell.percentage.textColor = .systemRed
            }else{
                cell.percentage.textColor = .systemBlue
            }
            cell.period.text = estateDataLists[indexPath.row].rateCalDateDiff
            cell.selectionStyle = .none
            return cell
            
        }else if label.text! == "#최근 가장 HOT한 주식" {
            cell.number.text = String(indexPath.row + 1)
            cell.iconImage.kf.setImage(with:  URL(string: stockDataLists[indexPath.row].iconImage))
            cell.title.text = self.stockDataLists[indexPath.row].name
            cell.price.text = "\(self.stockDataLists[indexPath.row].price)원"
            cell.percentage.text = "\(self.stockDataLists[indexPath.row].rateOfChange)%"
            if stockDataLists[indexPath.row].rateOfChange > 0 {
                cell.percentage.textColor = .systemRed
            }else{
                cell.percentage.textColor = .systemBlue
            }
            cell.period.text = stockDataLists[indexPath.row].rateCalDateDiff
            cell.selectionStyle = .none
            return cell
            
        }else if label.text! == "#어제 급등한 리셀"{
            cell.number.text = String(indexPath.row + 1)
            cell.iconImage.kf.setImage(with:  URL(string: resellDataLists[indexPath.row].imageUrl))
            cell.title.text = self.resellDataLists[indexPath.row].name
            cell.price.text = "\(self.resellDataLists[indexPath.row].price)원/m"
            cell.percentage.text = "\(self.resellDataLists[indexPath.row].rateOfChange)%"
            if resellDataLists[indexPath.row].rateOfChange > 0 {
                cell.percentage.textColor = .systemRed
            }else{
                cell.percentage.textColor = .systemBlue
            }
            cell.period.text = resellDataLists[indexPath.row].rateCalDateDiff
            cell.selectionStyle = .none
            return cell
        }else{
            return UITableViewCell()
        }
        
    }
    
}
