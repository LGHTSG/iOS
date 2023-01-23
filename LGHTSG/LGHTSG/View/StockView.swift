//
//  StockView.swift
//  LGHTSG
//
//  Created by SunHo Lee on 2023/01/22.
//
import UIKit
import Foundation
import SnapKit
class StockView : UIView {
    lazy private var  segment : UISegmentedControl = {
        let control  = UnderlineSegmentedControl(items: ["급상승", "급하락", "거래량", "시가총액"])
        control.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.darkGray, .font : UIFont.systemFont(ofSize: 16, weight: .semibold)], for: .normal)
        control.selectedSegmentIndex = 0
        AssetModel.requestTableCellModel(segmentIndex: 0){
            data in
            self.stockDataLists = data
        }
        return control
    }()
    let AssetModel = TableCellModel()
    var stockDataLists = [asset.body]()
    private var StockaTableView = UITableView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
        StockaTableView.dataSource = self
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
        self.addSubview(segment)
        segment.snp.makeConstraints{
            $0.leading.top.equalToSuperview()
            $0.height.equalTo(18)
        }
        self.addSubview(StockaTableView)
        StockaTableView.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(segment.snp.bottom).offset(22)
            $0.bottom.equalToSuperview()
        }
    }
}
extension StockView : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stockDataLists.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTabeCell", for: indexPath) as? HomeTableCell else {return UITableViewCell()}
        cell.setup(with: stockDataLists[indexPath.row])
        cell.countLabel.text = "\(indexPath.row+1)"
        return cell
        
    }
}
