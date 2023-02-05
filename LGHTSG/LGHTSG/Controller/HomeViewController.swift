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
    var myAssetData = [myasset.myBody]()
    var SellAssetData = [myasset.myBody]()
    var assetmodel = AssetModel()
    private var mytoken = UserDefaults.standard.string(forKey: "savedToken")
    override func viewDidLoad(){
        super.viewDidLoad()
        SetNavigationBar()
        setTobTabbar()
        setTable()
        segmentControl.addTarget(self, action: #selector(clicksegment), for: .valueChanged)
        getmyAssetData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getmyAssetData()
    }
    // 나의 자산, 판매한 자산
    @objc func clicksegment(_ sender : UISegmentedControl){
        if sender.selectedSegmentIndex == 0{
            underline1.backgroundColor = .white
            underline2.backgroundColor = .darkGray
            tableview.reloadData()
        }else{
            underline1.backgroundColor = .darkGray
            underline2.backgroundColor = .white
            tableview.reloadData()
        }
    }
    private func getmyAssetData(){
        assetmodel.requestMyAsset(token: mytoken!) {
            data in
            var tempselldata = [myasset.myBody]()
            var tempmyassetdata = [myasset.myBody]()
            for i in 0..<data.count{
                if(data[i].sellCheck == 1){
                    tempselldata.append(data[i])
                }
                else if (data[i].sellCheck == 0){
                    tempmyassetdata.append(data[i])
                }
            }
            self.SellAssetData = tempselldata
            self.myAssetData = tempmyassetdata
            self.tableview.reloadData()
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
        searchBtn.tintColor = .white
        navigationItem.leftBarButtonItem = searchBtn
        var config = UIButton.Configuration.plain()
        var attributeString = AttributedString(changepercent)
        attributeString.font = UIFont(name: "NanumSquareB", size: 12)
        attributeString.foregroundColor = UIColor.systemBlue
        config.attributedTitle = attributeString
        config.titleAlignment = .leading
        config.image = UIImage(named: "profile_mini")
        config.imagePadding = 8
        config.imagePlacement = .trailing
        let realbtn = UIButton(configuration: config)
        realbtn.addTarget(self, action: #selector(mypageClicked), for: .touchUpInside)
        let profileBtn = UIBarButtonItem(customView:realbtn )
        navigationItem.rightBarButtonItem = profileBtn
    }
    
    @objc func mypageClicked(){
        let vc = MyPageViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }

    @objc func showsearchbar(){
        layoutSearchBar()
    }
    func layoutSearchBar(){
        let searchbar = UISearchBar()
        searchbar.searchTextField.font = UIFont(name: "NanumSquareB" , size: 15)
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
        tableview.backgroundColor = .black
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
        let selectedIndex = self.segmentControl.selectedSegmentIndex
        switch selectedIndex{
        case 0:
            cell?.setup(home: myAssetData[indexPath.row])
        case 1:
            cell?.setup(home: SellAssetData[indexPath.row])
        default:
            return UITableViewCell()
        }
        cell?.countLabel.text = "\(indexPath.row+1)"
        cell?.backgroundColor = .black
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let selectedIndex = self.segmentControl.selectedSegmentIndex
        switch selectedIndex{
        case 0:
            return myAssetData.count
        case 1:
            return SellAssetData.count
        default:
            return 0
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.tableview.contentOffset.y < 0 {
            layoutSearchBar()
        }
        else if tableview.contentOffset.y>100 {
            SetNavigationBar()
        }
    }
}
