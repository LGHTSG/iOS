//
//  HomeViewController.swift
//  LGHTSG
//
//  Created by SunHo Lee on 2023/01/11.
//
import SnapKit
import Foundation
import UIKit
final class HomeViewController : UIViewController{
    private var segmentControl = UnderlineSegmentedControl(items: ["나의 자산", "판매한 자산"])
    var changepercent : String = "-7.2%"
    var tableview = UITableView()
    var underline1 = UnderlineView()
    var underline2 = UnderlineView()
    var assetList = [asset]()
    var assetmodel = AssetModel()
    override func viewDidLoad(){
        super.viewDidLoad()
        SetNavigationBar()
        setTobTabbar()
        segmentControl.addTarget(self, action: #selector(clicksegment), for: .valueChanged)
//        swipeGestureNavigationBar()
        setTable()
//        assetmodel.delegate = self
//        assetmodel.getAsset()
    }
    // 나의 자산, 판매한 자산
    @objc func clicksegment(_ sender : UISegmentedControl){
        if sender.selectedSegmentIndex == 0{
            underline1.backgroundColor = .white
            underline2.backgroundColor = .darkGray
        }else{
            underline1.backgroundColor = .darkGray
            underline2.backgroundColor = .white
        }
    }


}
private extension HomeViewController{

    // 네비게이션바 다시 생성
    @objc func shownavigationBar(){
        SetNavigationBar()
    }
    private func SetNavigationBar(){
        navigationItem.titleView = nil
        let searchBtn = UIBarButtonItem(image: UIImage(systemName : "magnifyingglass"), style: .plain, target: self, action: #selector(showsearchbar))
        navigationItem.leftBarButtonItem = searchBtn
        var config = UIButton.Configuration.plain()
        var attributeString = AttributedString(changepercent)
        attributeString.font = .systemFont(ofSize: 12, weight: .medium)
        attributeString.foregroundColor = UIColor.systemBlue
        config.attributedTitle = attributeString
        config.titleAlignment = .leading
        config.image = UIImage(named: "profile")
        config.imagePadding = 8
        config.imagePlacement = .trailing
        let realbtn = UIButton(configuration: config)
        let profileBtn = UIBarButtonItem(customView:realbtn )
        navigationItem.rightBarButtonItem = profileBtn
    }

    @objc func showsearchbar(){
        print(navigationItem.leftBarButtonItem)
    }
    func layoutSearchBar(){
        let searchbar = UISearchBar()
        searchbar.placeholder = "검색어를 입력해주세요"
        searchbar.searchTextField.backgroundColor = .clear
        navigationItem.leftBarButtonItem = .none
        navigationItem.rightBarButtonItem = .none
        self.navigationItem.titleView = searchbar
        let underline3 = UnderlineView()
        navigationItem.titleView?.addSubview(underline3)
        underline3.snp.makeConstraints{
            $0.bottom.equalToSuperview().offset(-8)
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(1.5)
        }
    }
    func setTobTabbar(){
        view.addSubview(segmentControl)
        view.addSubview(underline1)
        view.addSubview(underline2)
        underline1.backgroundColor = .white
        segmentControl.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(50)
        }
        underline1.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(20)
            $0.height.equalTo(1.5)
            $0.top.equalTo(segmentControl.snp.bottom).offset(-6)
            $0.trailing.equalToSuperview().inset(view.frame.width/2 + 5)
        }
        underline2.snp.makeConstraints{
            $0.leading.equalTo(view.snp.centerX).offset(5)
            $0.height.equalTo(1.5)
            $0.top.equalTo(segmentControl.snp.bottom).offset(-6)
            $0.trailing.equalToSuperview().inset(20)
        }
    }
    private func setTable(){
        view.addSubview(tableview)
        tableview.register(HomeTableCell.self, forCellReuseIdentifier: "HomeTableCell")
        tableview.delegate = self
        tableview.rowHeight = 56
        tableview.dataSource = self
        tableview.separatorStyle = .none
        tableview.snp.makeConstraints{
            $0.top.equalTo(underline1.snp.bottom).offset(32)
            $0.leading.trailing.equalToSuperview().inset(33)
            $0.bottom.equalToSuperview().inset(100)
        }
    }
}
extension HomeViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "HomeTableCell", for: indexPath) as? HomeTableCell
//        cell?.setup(with: assetList[indexPath.row])
        cell?.setuppp()
        cell?.countLabel.text = "\(indexPath.row+1)"
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        let selectedIndex = self.segmentControl.selectedSegmentIndex
//        switch selectedIndex{
//        case 0:
//            return assetList.count
//        case 1:
//            return assetList.count
//        default:
//            return 0
//        }
        20
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.tableview.contentOffset.y < 0 {
            let MaintabC = MainTabController()
            MaintabC.showsearchbar()
        }
        else if tableview.contentOffset.y>100 {
            let MaintabC = MainTabController()
            MaintabC.shownavigationBar()
        }
    }
}
//extension HomeViewController : AssetModelProtocol{
//    // MARK : assetmodel protocol function
//    func assetRetrived(assets : [asset]){
//        self.assetList = assets
//        tableview.reloadData()
//    }
//}
