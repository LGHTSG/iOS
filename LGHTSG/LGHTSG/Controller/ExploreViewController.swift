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
    var segmentControl = UnderlineSegmentedControl(items: ["Top", "부동산", "주식", "리셀"])
    let underline1 = UnderlineView()
    let underline2 = UnderlineView()
    let underline3 = UnderlineView()
    let underline4 = UnderlineView()
    var resellVC = resellView()
    static var isSearching = false
    let stockView = StockView()
    let TopView = TopViewController()
    let EstateVC = EstateController()
//    private lazy var reSellView : resellView = {
//        let view = resellView(coder: NSCoder)
//        return view
//    }()
    override func viewDidLoad() {
        super.viewDidLoad()
//        reSellView.delegate = self
        stockView.delegate = self
        SetNavigationBar()
        setTobTabbar()
        self.addChild(TopView)
        self.view.addSubview(TopView.view)
        TopView.view.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview().inset(23)
            $0.top.equalTo(underline4.snp.bottom).offset(32)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }

    }
    func setTobTabbar(){
        view.addSubview(segmentControl)
        view.addSubview(underline1)
        view.addSubview(underline2)
        view.addSubview(underline3)
        view.addSubview(underline4)
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
            $0.width.equalTo((view.frame.width - 36 - 12.5) / 4)
            $0.top.equalTo(segmentControl.snp.bottom).offset(-8)
        }
        underline2.snp.makeConstraints{
            $0.leading.equalTo(underline1.snp.trailing).offset(4.5)
            $0.height.equalTo(1)
            $0.width.equalTo((view.frame.width - 36 - 12.5) / 4)
            $0.top.equalTo(segmentControl.snp.bottom).offset(-8)
        }
        underline3.snp.makeConstraints{
            $0.leading.equalTo(underline2.snp.trailing).offset(3.5)
            $0.height.equalTo(1)
            $0.width.equalTo((view.frame.width - 36 - 12.5) / 4)
            $0.top.equalTo(segmentControl.snp.bottom).offset(-8)
        }
        underline4.snp.makeConstraints{
            $0.leading.equalTo(underline3.snp.trailing).offset(4.5)
            $0.height.equalTo(1)
            $0.width.equalTo((view.frame.width - 36 - 12.5) / 4)
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
            underline1.backgroundColor = .white
            underline2.backgroundColor = .darkGray
            underline3.backgroundColor = .darkGray
            underline4.backgroundColor  = .darkGray
            self.addChild(TopView)
            self.view.addSubview(TopView.view)
            TopView.view.snp.makeConstraints{
                $0.leading.trailing.equalToSuperview().inset(23)
                $0.top.equalTo(underline4.snp.bottom).offset(32)
                $0.bottom.equalTo(view.safeAreaLayoutGuide)
            }

        case 1:
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
            underline2.backgroundColor = .white
            underline3.backgroundColor = .darkGray
            underline4.backgroundColor = .darkGray
            

        case 2:
            TopView.removeFromParent()
            TopView.view.removeFromSuperview()
            EstateVC.removeFromParent()
            EstateVC.view.removeFromSuperview()
            resellVC.removeFromParent()
            resellVC.view.removeFromSuperview()
            underline1.backgroundColor = .darkGray
            underline2.backgroundColor = .darkGray
            underline3.backgroundColor = .white
            underline4.backgroundColor = .darkGray
            self.addChild(stockView)
            self.view.addSubview(stockView.view)
            stockView.view.snp.makeConstraints{
                $0.leading.trailing.equalToSuperview().inset(23)
                $0.top.equalTo(underline4.snp.bottom).offset(32)
                $0.bottom.equalTo(view.safeAreaLayoutGuide)
            }
            
          
        case 3:
            TopView.removeFromParent()
            TopView.view.removeFromSuperview()
            stockView.removeFromParent()
            stockView.view.removeFromSuperview()
            EstateVC.removeFromParent()
            EstateVC.view.removeFromSuperview()
            underline1.backgroundColor = .darkGray
            underline2.backgroundColor = .darkGray
            underline3.backgroundColor = .darkGray
            underline4.backgroundColor = .white

            
            resellVC.delegate = self
            self.addChild(resellVC)
            self.view.addSubview(resellVC.view)
            resellVC.view.snp.makeConstraints{
                $0.leading.trailing.equalToSuperview().inset(23)
                $0.top.equalTo(underline4.snp.bottom).offset(32)
                $0.bottom.equalTo(view.safeAreaLayoutGuide)
            }
            
            
            
//            reSellView.alpha = 1
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
        let searchBtn = UIBarButtonItem(image: UIImage(systemName : "magnifyingglass"), style: .plain, target: self, action: #selector(showsearchbar))
        navigationItem.leftBarButtonItem = searchBtn
        var config = UIButton.Configuration.plain()
        var attributeString = AttributedString("-93")
        attributeString.font = .systemFont(ofSize: 12, weight: .medium)
        attributeString.foregroundColor = UIColor.systemBlue
        config.attributedTitle = attributeString
        config.titleAlignment = .leading
        config.image = UIImage(named: "profile_mini")
        config.imagePadding = 8
        config.imagePlacement = .trailing
        let realbtn = UIButton(configuration: config)
        let profileBtn = UIBarButtonItem(customView:realbtn )
        realbtn.addTarget(self, action: #selector(profileBtnClicked2), for: .touchUpInside)
        navigationItem.rightBarButtonItem = profileBtn
    }
    
    @objc func profileBtnClicked2(){
        print("마이페이지 가는중")
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
