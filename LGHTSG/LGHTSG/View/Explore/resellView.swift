//
//  ResellView.swift
//  LGHTSG
//
//  Created by SunHo Lee on 2023/01/23.
//

import UIKit
import Foundation
import SnapKit
class resellView : UIView{
    let AssetModel = TableCellModel()
    var resellDataLists = [ResellPrice.body]()
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
    private var resellTableView = UITableView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
        resellTableView.dataSource = self
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
        self.addSubview(segment)
        segment.snp.makeConstraints{
            $0.leading.top.equalToSuperview()
            $0.height.equalTo(18)
        }
        self.addSubview(resellTableView)
        resellTableView.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(segment.snp.bottom).offset(22)
            $0.bottom.equalToSuperview()
        }
    }
}
extension resellView : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resellDataLists.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTabeCell", for: indexPath) as? HomeTableCell else {return UITableViewCell()}
        cell.setup(with: resellDataLists[indexPath.row])
        cell.countLabel.text = "\(indexPath.row+1)"
        return cell
        
    }
}


