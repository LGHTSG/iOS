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
    var changepercent = "0%"
    var tableview = UITableView()
    var underline1 = UnderlineView()
    var underline2 = UnderlineView()
    var myAssetData = [myasset.myBody]()
    var SellAssetData = [myasset.myBody]()
    var assetmodel = AssetModel()
    private var mytoken = UserDefaults.standard.string(forKey: "savedToken")
    override func viewDidLoad(){
        view.backgroundColor = .black
        super.viewDidLoad()
        let userRoemodel = UserRoeModel()
        userRoemodel.getUserROE(token: mytoken!){
            data in
            self.changepercent = String(format:"%.2f",data.rate)+"%"
            self.SetNavigationBar()
        }
        
        setTobTabbar()
        setTable()
        segmentControl.addTarget(self, action: #selector(clicksegment), for: .valueChanged)
        getmyAssetData()
    }
    //keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            view.endEditing(true)
        }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getmyAssetData()
        let userRoemodel = UserRoeModel()
        userRoemodel.getUserROE(token: mytoken!){
            data in
            self.changepercent = String(format:"%.2f",data.rate)+"%"
            self.SetNavigationBar()
        }
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
        config.image = UIImage(named: "profile-money-mini")
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
        searchbar.searchTextField.textColor = .white
        searchbar.tintColor = .white
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
        cell?.selectionStyle = .none
        
        // MARK: 세그먼트 폰트 설정
        // 선택안된 버튼 폰트
        segmentControl.setTitleTextAttributes([
                    NSAttributedString.Key.foregroundColor: UIColor.systemGray,
                    NSAttributedString.Key.font: UIFont(name: "NanumSquareEB", size: 17)
                ], for: .normal)
        
        // 선택된 버튼 폰트
        segmentControl.setTitleTextAttributes([
                    NSAttributedString.Key.foregroundColor: UIColor.white,
                    NSAttributedString.Key.font: UIFont(name: "NanumSquareEB", size: 17)
                ], for: .selected)

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
        let selectedIndex = self.segmentControl.selectedSegmentIndex
        switch selectedIndex{
        case 0:
            if(myAssetData[indexPath.row].category == "resell"){
                let ChartVc = ReSellChartViewController()
                ChartVc.nameText =  myAssetData[indexPath.row].assetName
                ChartVc.changeDateText = myAssetData[indexPath.row].rateCalDateDiff
                ChartVc.pricePercentText = "\(myAssetData[indexPath.row].rateOfChange)%"
                ChartVc.PriceText  = "\(String(myAssetData[indexPath.row].price))원"
                ChartVc.idx = myAssetData[indexPath.row].assetIdx
                ChartVc.imageURL = myAssetData[indexPath.row].iconImage
                ChartVc.navigationItem.leftBarButtonItem?.tintColor = .white
                self.navigationController?.pushViewController(ChartVc, animated: true)
            }
            else if (myAssetData[indexPath.row].category == "stock"){
                let StockVC = StockChartViewController()
                StockVC.nameText =  myAssetData[indexPath.row].assetName
                StockVC.changeDateText = myAssetData[indexPath.row].rateCalDateDiff
                StockVC.pricePercentText = "\(myAssetData[indexPath.row].rateOfChange)%"
//                StockVC.  = "\(String(myAssetData[indexPath.row].price))원"
                StockVC.idx = myAssetData[indexPath.row].assetIdx
                StockVC.navigationItem.leftBarButtonItem?.tintColor = .white
                self.navigationController?.pushViewController(StockVC, animated: true)
            }
            // 부동산일꺼아냐
            else{
                let estateChartVC = EstateChartViewController()
                estateChartVC.nameText =  myAssetData[indexPath.row].assetName
                estateChartVC.changeDateText = myAssetData[indexPath.row].rateCalDateDiff
                estateChartVC.pricePercentText = "\(myAssetData[indexPath.row].rateOfChange)%"
                estateChartVC.idx = myAssetData[indexPath.row].assetIdx
                estateChartVC.navigationItem.leftBarButtonItem?.tintColor = .white
                self.navigationController?.pushViewController(estateChartVC, animated: true)
            }
        case 1:
            if(SellAssetData[indexPath.row].category == "resell"){
                let ChartVc = ReSellChartViewController()
                ChartVc.nameText =  SellAssetData[indexPath.row].assetName
                ChartVc.changeDateText = SellAssetData[indexPath.row].rateCalDateDiff
                ChartVc.pricePercentText = "\(SellAssetData[indexPath.row].rateOfChange)%"
                ChartVc.PriceText  = "\(String(SellAssetData[indexPath.row].price))원"
                ChartVc.idx = SellAssetData[indexPath.row].assetIdx
                ChartVc.imageURL = SellAssetData[indexPath.row].iconImage
                ChartVc.navigationItem.leftBarButtonItem?.tintColor = .white
                self.navigationController?.pushViewController(ChartVc, animated: true)
            }
            else if (SellAssetData[indexPath.row].category == "stock"){
                let StockVC = StockChartViewController()
                StockVC.nameText =  SellAssetData[indexPath.row].assetName
                StockVC.changeDateText = SellAssetData[indexPath.row].rateCalDateDiff
                StockVC.pricePercentText = "\(SellAssetData[indexPath.row].rateOfChange)%"
//                StockVC.  = "\(String(myAssetData[indexPath.row].price))원"
                StockVC.idx = SellAssetData[indexPath.row].assetIdx
                StockVC.navigationItem.leftBarButtonItem?.tintColor = .white
                self.navigationController?.pushViewController(StockVC, animated: true)
            }
            else{
                let estateChartVC = EstateChartViewController()
                estateChartVC.nameText =  SellAssetData[indexPath.row].assetName
                estateChartVC.changeDateText = SellAssetData[indexPath.row].rateCalDateDiff
                estateChartVC.pricePercentText = "\(SellAssetData[indexPath.row].rateOfChange)%"
                estateChartVC.idx = SellAssetData[indexPath.row].assetIdx
                estateChartVC.navigationItem.leftBarButtonItem?.tintColor = .white
                self.navigationController?.pushViewController(estateChartVC, animated: true)
            }
        default: print("error")
        }
    }
    // tableview cell 삭제 내 자산 삭제
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //            tableView.beginUpdates()
            let AssetModel = AssetModel()
            switch( self.segmentControl.selectedSegmentIndex){
            case 0:
                AssetModel.deleteMyAsset(token: self.mytoken!, transactionIdx: myAssetData[indexPath.row].assetIdx, category: myAssetData[indexPath.row].category){
                    data in
                    //요청에 성공한 경우
                    if(data.header.resultCode == 1000){
                        let alertv = UIAlertController(title: "삭제완료", message: "삭제가 완료되었습니다", preferredStyle: UIAlertController.Style.alert)
                        alertv.addAction(UIAlertAction(title: "OK", style: .default))
                        self.present(alertv, animated: true){
                            //                        tableView.deleteRows(at: [indexPath], with: .fade)
                            self.getmyAssetData()
                            //                        tableView.endUpdates()
                        }
                    }
                    else{
                        let alertv = UIAlertController(title: "ERROR", message: "삭제 실패", preferredStyle: UIAlertController.Style.alert)
                        alertv.addAction(UIAlertAction(title: "OK", style: .default))
                        self.present(alertv,animated: true)
                    }
                }
            case 1:
                AssetModel.deleteMyAsset(token: mytoken!, transactionIdx: SellAssetData[indexPath.row].assetIdx, category: SellAssetData[indexPath.row].category){
                    data in
                    //요청에 성공한 경우
                    if(data.header.resultCode == 1000){
                        let alertv = UIAlertController(title: "삭제완료", message: "삭제가 완료되었습니다", preferredStyle: UIAlertController.Style.alert)
                        alertv.addAction(UIAlertAction(title: "OK", style: .default))
                        self.present(alertv, animated: true){
                            //                        tableView.deleteRows(at: [indexPath], with: .fade)
                            self.getmyAssetData()
                            //                        tableView.endUpdates()
                        }
                    }
                    else{
                        let alertv = UIAlertController(title: "ERROR", message: "삭제 실패", preferredStyle: UIAlertController.Style.alert)
                        alertv.addAction(UIAlertAction(title: "OK", style: .default))
                        self.present(alertv,animated: true)
                    }
                }
            default:
                break
            }}
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
