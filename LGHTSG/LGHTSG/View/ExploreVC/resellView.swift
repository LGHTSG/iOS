//
//  ResellView.swift
//  LGHTSG
//
//  Created by SunHo Lee on 2023/01/23.
//

import UIKit
import Foundation
import SnapKit
protocol showNavigationDelegate{
    func hideSearchBar()
    func showSearchBar()
}

class resellView : UIViewController{
    var delegate : showNavigationDelegate?
    let AssetModel = TableCellModel()
    var resellDataLists = [ResellPrice.body]()
    var resellSearchLists = [ResellPrice.body]()
    lazy private var segment : UISegmentedControl = {
        let control  = UnderlineSegmentedControl(items: ["급상승", "급하락", "거래량"])
        control.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.darkGray, .font : UIFont.systemFont(ofSize: 16, weight: .semibold)], for: .normal)
        control.selectedSegmentIndex = 0
        AssetModel.requestResellModel(segmentIndex: 0){
            data in
            self.resellDataLists = data
            self.resellTableView.reloadData()
        }
        return control
    }()
    var resellTableView = UITableView()
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setView()
//        resellTableView.dataSource = self
//        resellTableView.delegate = self
//        segment.addTarget(self, action: #selector(clickSegment), for: .valueChanged)
////        let superview = ExploreViewController()
////        superview.delegate1 = self
//    }

    init(){
        super.init(nibName: nil, bundle: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        view.backgroundColor = .black
        resellTableView.dataSource = self
        resellTableView.delegate = self
        segment.addTarget(self, action: #selector(clickSegment), for: .valueChanged)
    }
    //segment이벤트 받아서 급상승, 급하락, 거래량
    @objc func clickSegment(_ sender : UISegmentedControl){
        switch sender.selectedSegmentIndex {
        case 0:
            AssetModel.requestResellModel(segmentIndex: 0){
                data in
                self.resellDataLists = data
                self.resellTableView.reloadData()
            }
        case 1:
            AssetModel.requestResellModel(segmentIndex: 1){
                data in
                self.resellDataLists = data
                self.resellTableView.reloadData()}
        case 2:
            AssetModel.requestResellModel(segmentIndex: 2){
                data in
                self.resellDataLists = data
                self.resellTableView.reloadData()}
        default: break
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setView() {
        resellTableView.register(HomeTableCell.self, forCellReuseIdentifier: "HomeTabeCell")
        resellTableView.separatorStyle = .none
        resellTableView.backgroundColor = .black
        self.view.addSubview(segment)
        segment.snp.makeConstraints{
            $0.leading.top.equalToSuperview()
            $0.height.equalTo(18)
        }
        self.view.addSubview(resellTableView)
        resellTableView.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(segment.snp.bottom).offset(22)
            $0.bottom.equalToSuperview()
        }
    }
}
extension resellView : UITableViewDataSource , UITableViewDelegate, UIScrollViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(ExploreViewController.isSearching){
            return resellSearchLists.count
        }else{
            return resellDataLists.count  }}
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTabeCell", for: indexPath) as? HomeTableCell else {return UITableViewCell()}
        if(ExploreViewController.isSearching){
            cell.setup(with: resellSearchLists[indexPath.row])
        }else{
            cell.setup(with: resellDataLists[indexPath.row])}
        cell.countLabel.text = "\(indexPath.row+1)"
        
        return cell
        
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if resellTableView.contentOffset.y < 0 {
            delegate?.showSearchBar()
        }
        else if resellTableView.contentOffset.y>100 {
            delegate?.hideSearchBar()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ChartVc = ChartViewController()
        
       
        if(ExploreViewController.isSearching){
            ChartVc.nameText =  resellSearchLists[indexPath.row].name
            ChartVc.changeDateText = String(resellSearchLists[indexPath.row].rateOfChange)
            ChartVc.pricePercentText = resellSearchLists[indexPath.row].rateCalDateDiff
            ChartVc.PriceText  = "\(String(resellSearchLists[indexPath.row].price))원"
            ChartVc.idx = resellSearchLists[indexPath.row].idx
            ChartVc.imageURL = resellSearchLists[indexPath.row].imageUrl
        }else{
            ChartVc.nameText =  resellDataLists[indexPath.row].name
            ChartVc.changeDateText = String(resellDataLists[indexPath.row].rateOfChange)
            ChartVc.pricePercentText = resellDataLists[indexPath.row].rateCalDateDiff
            ChartVc.PriceText  = "\(String(resellDataLists[indexPath.row].price))원"
            ChartVc.idx = resellDataLists[indexPath.row].idx
            ChartVc.imageURL = resellDataLists[indexPath.row].imageUrl
        }

        self.navigationController?.pushViewController(ChartVc, animated: true)
    }
}
