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
    static var isSearching = false
    let stockView = StockView()
    private lazy var reSellView : resellView = {
        let view = resellView()
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        reSellView.delegate = self
        stockView.delegate = self
        SetNavigationBar()
        setTobTabbar()
        setView()
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
            underline1.backgroundColor = .white
            underline2.backgroundColor = .darkGray
            underline3.backgroundColor = .darkGray
            underline4.backgroundColor  = .darkGray
            stockView.alpha = 0
            reSellView.alpha = 0
        case 1:
            underline1.backgroundColor = .darkGray
            underline2.backgroundColor = .white
            underline3.backgroundColor = .darkGray
            underline4.backgroundColor = .darkGray
            stockView.alpha = 0
            reSellView.alpha = 0
        case 2:
            underline1.backgroundColor = .darkGray
            underline2.backgroundColor = .darkGray
            underline3.backgroundColor = .white
            underline4.backgroundColor = .darkGray
            stockView.alpha = 1
            reSellView.alpha = 0
        case 3:
            underline1.backgroundColor = .darkGray
            underline2.backgroundColor = .darkGray
            underline3.backgroundColor = .darkGray
            underline4.backgroundColor = .white
            stockView.alpha = 0
            reSellView.alpha = 1
        default: break
        }
    }
}
extension ExploreViewController {
    
    private func setView(){
        self.view.addSubview(reSellView)
        self.view.addSubview(stockView)
        stockView.alpha = 0
        reSellView.alpha = 0
        reSellView.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview().inset(23)
            $0.top.equalTo(underline4.snp.bottom).offset(32)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        stockView.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview().inset(23)
            $0.top.equalTo(underline4.snp.bottom).offset(32)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
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
        config.image = UIImage(named: "profile")
        config.imagePadding = 8
        config.imagePlacement = .trailing
        let realbtn = UIButton(configuration: config)
        let profileBtn = UIBarButtonItem(customView:realbtn )
        navigationItem.rightBarButtonItem = profileBtn
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
            reSellView.resellSearchLists = reSellView.resellDataLists.filter{
                $0.name.contains(searchText)
            }}
        reSellView.resellTableView.reloadData()
//        delegate1?.searchData(data: searchText)
    }
}
