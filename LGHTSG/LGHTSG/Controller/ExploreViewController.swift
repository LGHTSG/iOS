//
//  ExploreViewController.swift
//  LGHTSG
//
//  Created by SunHo Lee on 2023/01/11.
//

import UIKit
import SnapKit
protocol searchDataFilterDelegate{
    func searchData(data : String)
}
class ExploreViewController : UIViewController {
    var delegate1 : searchDataFilterDelegate?
    var segmentControl = UnderlineSegmentedControl(items: ["Rank","Top", "부동산", "주식", "리셀"])
    let underline1 = UnderlineView()
    let underline2 = UnderlineView()
    let underline3 = UnderlineView()
    let underline5 = UnderlineView()
    let underline4 = UnderlineView()
    private var changepercent = "0%"
    var resellVC = resellView()
    static var isSearching = false
    let stockView = StockView()
    let TopView = TopViewController()
    let EstateVC = EstateController()
    let rankVC = RankViewController()

    private var mytoken = UserDefaults.standard.string(forKey: "savedToken")
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        


        let userRoemodel = UserRoeModel()
        userRoemodel.getUserROE(token: mytoken!){
            data in
            self.changepercent = String(format:"%.2f",data.rate)+"%"
            self.SetNavigationBar()
        }
        stockView.delegate = self
        setTobTabbar()
        
        self.addChild(rankVC)
        self.view.addSubview(rankVC.view)
        rankVC.view.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview().inset(23)
            $0.top.equalTo(underline4.snp.bottom).offset(32)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
//        self.addChild(TopView)
//        self.view.addSubview(TopView.view)
//        TopView.view.snp.makeConstraints{
//            $0.leading.trailing.equalToSuperview().inset(23)
//            $0.top.equalTo(underline4.snp.bottom).offset(32)
//            $0.bottom.equalTo(view.safeAreaLayoutGuide)
//        }

    }
    //keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            view.endEditing(true)
        }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let userRoemodel = UserRoeModel()
        userRoemodel.getUserROE(token: mytoken!){
            data in
            self.changepercent = String(format:"%.2f",data.rate)+"%"
            self.SetNavigationBar()
        }
    }
    func setTobTabbar(){
        view.addSubview(segmentControl)
        view.addSubview(underline1)
        view.addSubview(underline2)
        view.addSubview(underline3)
        view.addSubview(underline4)
        view.addSubview(underline5)
        
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
        
        
        segmentControl.addTarget(self, action: #selector(clickfoursegment), for: .valueChanged)
        segmentControl.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(48)
        }
        underline1.backgroundColor = .white
        underline1.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(18)
            $0.height.equalTo(1)
            $0.width.equalTo((view.frame.width - 36 - 12.5) / 5)
            $0.top.equalTo(segmentControl.snp.bottom).offset(-8)
        }
        underline2.snp.makeConstraints{
            $0.leading.equalTo(underline1.snp.trailing).offset(4.5)
            $0.height.equalTo(1)
            $0.width.equalTo((view.frame.width - 36 - 12.5) / 5)
            $0.top.equalTo(segmentControl.snp.bottom).offset(-8)
        }
        underline3.snp.makeConstraints{
            $0.leading.equalTo(underline2.snp.trailing).offset(3.5)
            $0.height.equalTo(1)
            $0.width.equalTo((view.frame.width - 36 - 12.5) / 5)
            $0.top.equalTo(segmentControl.snp.bottom).offset(-8)
        }
        underline4.snp.makeConstraints{
            $0.leading.equalTo(underline3.snp.trailing).offset(4.5)
            $0.height.equalTo(1)
            $0.width.equalTo((view.frame.width - 36 - 12.5) / 5)
            $0.top.equalTo(segmentControl.snp.bottom).offset(-8)
        }
        underline5.snp.makeConstraints{
            $0.leading.equalTo(underline4.snp.trailing).offset(4.5)
            $0.height.equalTo(1)
            $0.width.equalTo((view.frame.width - 36 - 12.5) / 5)
            $0.top.equalTo(segmentControl.snp.bottom).offset(-8)
        }
    }
    @objc func clickfoursegment(_ sender : UISegmentedControl){
        switch sender.selectedSegmentIndex {
        case 0:
            stockView.removeFromParent()
            stockView.view.removeFromSuperview()
            resellVC.removeFromParent()
            resellVC.view.removeFromSuperview()
            EstateVC.removeFromParent()
            EstateVC.view.removeFromSuperview()
            TopView.view.removeFromSuperview()
            TopView.removeFromParent()
            underline1.backgroundColor = .white
            underline2.backgroundColor = .darkGray
            underline3.backgroundColor = .darkGray
            underline4.backgroundColor  = .darkGray
            underline5.backgroundColor = .darkGray
            self.addChild(rankVC)
            self.view.addSubview(rankVC.view)
            rankVC.view.snp.makeConstraints{
                $0.leading.trailing.equalToSuperview().inset(23)
                $0.top.equalTo(underline4.snp.bottom).offset(32)
                $0.bottom.equalTo(view.safeAreaLayoutGuide)
            }

        case 1:
            rankVC.removeFromParent()
            rankVC.view.removeFromSuperview()
            stockView.removeFromParent()
            stockView.view.removeFromSuperview()
            resellVC.removeFromParent()
            resellVC.view.removeFromSuperview()
            EstateVC.removeFromParent()
            EstateVC.view.removeFromSuperview()
            underline1.backgroundColor = .darkGray
            underline2.backgroundColor = .white
            underline3.backgroundColor = .darkGray
            underline4.backgroundColor  = .darkGray
            underline5.backgroundColor = .darkGray
            self.addChild(TopView)
            self.view.addSubview(TopView.view)
            TopView.view.snp.makeConstraints{
                $0.leading.trailing.equalToSuperview().inset(23)
                $0.top.equalTo(underline4.snp.bottom).offset(32)
                $0.bottom.equalTo(view.safeAreaLayoutGuide)
            }
 
            

        case 2:
            rankVC.removeFromParent()
            rankVC.view.removeFromSuperview()
            stockView.removeFromParent()
            stockView.view.removeFromSuperview()
            resellVC.removeFromParent()
            resellVC.view.removeFromSuperview()
            TopView.removeFromParent()
            TopView.view.removeFromSuperview()
            self.addChild(EstateVC)
            self.view.addSubview(EstateVC.view)
            EstateVC.view.snp.makeConstraints{
                $0.leading.trailing.equalToSuperview().inset(23)
                $0.top.equalTo(underline4.snp.bottom).offset(32)
                $0.bottom.equalTo(view.safeAreaLayoutGuide)
            }
            underline1.backgroundColor = .darkGray
            underline2.backgroundColor = .darkGray
            underline3.backgroundColor = .white
            underline4.backgroundColor = .darkGray
            underline5.backgroundColor = .darkGray
  
            
          
        case 3:
            rankVC.removeFromParent()
            rankVC.view.removeFromSuperview()
            TopView.removeFromParent()
            TopView.view.removeFromSuperview()
            EstateVC.removeFromParent()
            EstateVC.view.removeFromSuperview()
            resellVC.removeFromParent()
            resellVC.view.removeFromSuperview()
            underline1.backgroundColor = .darkGray
            underline2.backgroundColor = .darkGray
            underline3.backgroundColor = .darkGray
            underline4.backgroundColor = .white
            self.addChild(stockView)
            self.view.addSubview(stockView.view)
            stockView.view.snp.makeConstraints{
                $0.leading.trailing.equalToSuperview().inset(23)
                $0.top.equalTo(underline4.snp.bottom).offset(32)
                $0.bottom.equalTo(view.safeAreaLayoutGuide)
            }
            underline5.backgroundColor = .darkGray

        case 4:
            rankVC.removeFromParent()
            rankVC.view.removeFromSuperview()
            TopView.removeFromParent()
            TopView.view.removeFromSuperview()
            stockView.removeFromParent()
            stockView.view.removeFromSuperview()
            EstateVC.removeFromParent()
            EstateVC.view.removeFromSuperview()
            underline1.backgroundColor = .darkGray
            underline2.backgroundColor = .darkGray
            underline3.backgroundColor = .darkGray
            underline4.backgroundColor = .darkGray
            underline5.backgroundColor = .white
            resellVC.delegate = self
            self.addChild(resellVC)
            self.view.addSubview(resellVC.view)
            resellVC.view.snp.makeConstraints{
                $0.leading.trailing.equalToSuperview().inset(23)
                $0.top.equalTo(underline4.snp.bottom).offset(32)
                $0.bottom.equalTo(view.safeAreaLayoutGuide)
            }
        default: break
        }
    }
}
extension ExploreViewController : showNavigationDelegate{
    func showSearchBar() {
        layoutSearchBar()
    }
    func hideSearchBar() {
        SetNavigationBar()
    }
    func SetNavigationBar(){
        ExploreViewController.isSearching = false
        navigationItem.titleView = nil
        navigationController?.navigationBar.tintColor  = .white
        let searchBtn = UIBarButtonItem(image: UIImage(systemName : "magnifyingglass"), style: .plain, target: self, action: #selector(showsearchbar))
        searchBtn.tintColor = .white
        navigationItem.leftBarButtonItem = searchBtn
        var config = UIButton.Configuration.plain()
        var attributeString = AttributedString(changepercent)
        
        attributeString.font =  UIFont(name: "NanumSquareEB", size: 12)
        attributeString.foregroundColor = UIColor.systemBlue
        config.attributedTitle = attributeString
        config.titleAlignment = .leading
        config.image = UIImage(named: "profile-money-mini")
        config.imagePadding = 8
        config.imagePlacement = .trailing
        
        let realbtn = UIButton(configuration: config)
        let profileBtn = UIBarButtonItem(customView:realbtn )
        realbtn.addTarget(self, action: #selector(mypageClicked), for: .touchUpInside)
        
        navigationItem.rightBarButtonItem = profileBtn
        let navigationAppearance = UINavigationBarAppearance()
        navigationAppearance.backgroundColor = .black
        self.navigationController?.navigationBar.scrollEdgeAppearance = navigationAppearance
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
        searchbar.delegate = self
        searchbar.placeholder = "검색어를 입력해주세요"
        searchbar.searchTextField.font = UIFont(name: "NanumSquareB", size: 13)
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
}

extension ExploreViewController :UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(searchText.isEmpty){
            ExploreViewController.isSearching = false
        }
        else{
            ExploreViewController.isSearching = true
            resellVC.resellSearchLists = resellVC.resellDataLists.filter{
                $0.name.contains(searchText)
            }}
        stockView.stockSearchLists = stockView.stockDataLists.filter{
            $0.name.contains(searchText)
        }
        stockView.StockaTableView.reloadData()
            resellVC.resellTableView.reloadData()

    }
}
