//
//  StockView.swift
//  LGHTSG
//
//  Created by SunHo Lee on 2023/01/22.
//
import UIKit
import Foundation
import SnapKit
class StockView : UIViewController {
    var delegate : showNavigationDelegate?
    lazy private var  segment : UISegmentedControl = {
        let control  = UnderlineSegmentedControl(items: ["급상승", "급하락", "거래량", "시가총액"])
        control.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.darkGray, .font : UIFont(name: "NanumSquareEB", size: 16)], for: .normal)
        control.selectedSegmentIndex = 0
        AssetModel.requestTableCellModel(segmentIndex: 0){
            data in
            self.stockDataLists = data
            self.StockaTableView.reloadData()
        }
        return control
    }()
    
    
    let AssetModel = TableCellModel()
    var stockDataLists = [asset.body]()
    var stockSearchLists = [asset.body]()
    init(){
        super.init(nibName: nil, bundle: nil)
    }
    var StockaTableView = UITableView()
    override func viewDidLoad() {
        setView()
        view.backgroundColor = .black
        StockaTableView.dataSource = self
        StockaTableView.delegate = self
        segment.addTarget(self, action: #selector(clickSegment), for: .valueChanged)
    }
    //segment이벤트 받아서 급상승, 급하락, 거래량, 시가총액을 구분. 
    @objc func clickSegment(_ sender : UISegmentedControl){
        switch sender.selectedSegmentIndex {
        case 0:
            AssetModel.requestTableCellModel(segmentIndex: 0){
                data in
                self.stockDataLists = data
                self.StockaTableView.reloadData()
            }
        case 1:
            AssetModel.requestTableCellModel(segmentIndex: 1){
                data in
                self.stockDataLists = data
                self.StockaTableView.reloadData()}
        case 2:
            AssetModel.requestTableCellModel(segmentIndex: 2){
                data in
                self.stockDataLists = data
                self.StockaTableView.reloadData()}
        case 3:
            AssetModel.requestTableCellModel(segmentIndex: 3){
                data in
                self.stockDataLists = data
                self.StockaTableView.reloadData()}
        default: break
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setView(){
        StockaTableView.register(HomeTableCell.self, forCellReuseIdentifier: "HomeTabeCell")
        StockaTableView.separatorStyle = .none

        StockaTableView.backgroundColor = .black
        self.view.addSubview(segment)
        segment.snp.makeConstraints{
            $0.leading.top.equalToSuperview()
            $0.height.equalTo(18)
        }
        self.view.addSubview(StockaTableView)
        StockaTableView.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(segment.snp.bottom).offset(22)
            $0.bottom.equalToSuperview()
        }
    }
}
extension StockView : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(ExploreViewController.isSearching){
            return stockSearchLists.count
        }else{
            return stockDataLists.count}
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTabeCell", for: indexPath) as? HomeTableCell else {return UITableViewCell()}
        if(ExploreViewController.isSearching){
            cell.setup(with: stockSearchLists[indexPath.row])
        }
        else{cell.setup(with: stockDataLists[indexPath.row])}
        cell.countLabel.text = "\(indexPath.row+1)"
        cell.selectionStyle = .none

        cell.backgroundColor = .black
        return cell
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if StockaTableView.contentOffset.y < 0 {
            delegate?.showSearchBar()
        }
        else if StockaTableView.contentOffset.y>100 {
            delegate?.hideSearchBar()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ChartVc = StockChartViewController()
        if(ExploreViewController.isSearching){
            ChartVc.nameText =  stockSearchLists[indexPath.row].name
            ChartVc.changeDateText = ((stockSearchLists[indexPath.row].rateCalDateDiff))
            ChartVc.pricePercentText = "\(stockSearchLists[indexPath.row].rateOfChange)%"
            ChartVc.idx = stockSearchLists[indexPath.row].idx

        }else{
            ChartVc.nameText =  stockDataLists[indexPath.row].name
            ChartVc.changeDateText = (stockDataLists[indexPath.row].rateCalDateDiff)
            ChartVc.pricePercentText = "\(stockDataLists[indexPath.row].rateOfChange)%"
            ChartVc.idx = stockDataLists[indexPath.row].idx
          
        }

        self.navigationController?.pushViewController(ChartVc, animated: true)
    }
}
