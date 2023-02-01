//
//  MainTabController.swift
//  LGHTSG
//
//  Created by HA on 2023/01/09.
//

import UIKit
import Foundation
class MainTabController: UITabBarController {
    var changepercent : String = "-7.2%"
    override func viewDidLoad() {
        view.backgroundColor = .black
        super.viewDidLoad()
//        SetNavigationBar()
//        swipeGestureNavigationBar()
        let systemFontAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12.0, weight: .semibold)]
        UITabBarItem.appearance().setTitleTextAttributes(systemFontAttributes, for: .normal)
        let HomeVC = UINavigationController(rootViewController: HomeViewController())
        HomeVC.tabBarItem.title = "Home"
        HomeVC.tabBarItem.image = UIImage(named: "home2")
        HomeVC.tabBarItem.selectedImage = UIImage(named: "home")
        let ExploreVC = UINavigationController(rootViewController:ExploreViewController())
        ExploreVC.tabBarItem.title = "Explore"
        ExploreVC.tabBarItem.image = UIImage(named : "compass")
        ExploreVC.tabBarItem.selectedImage = UIImage(named: "compass2")
        tabBar.layer.borderColor = UIColor.label.cgColor
        tabBar.clipsToBounds = false
        viewControllers = [HomeVC,ExploreVC]

        addSeparatorToTabBar()
       
        
    }
    private func addSeparatorToTabBar() {
        if tabBar.items != nil{
            //Get the height of the tab bar
            let height = (tabBar.bounds).height
            let itemSize = CGSize(
                width: (tabBar.frame.width) / 2,
                height: (tabBar.frame.size.height))
            let xPosition = itemSize.width * CGFloat(1)
            let separator = UIView(frame: CGRect(
                x: xPosition, y: 0, width: 0.7, height: height))
            separator.backgroundColor = UIColor.label
            tabBar.insertSubview(separator, at: 0)
            let separator2 = UIView(frame: CGRect(x: 0, y: 0, width: tabBar.frame.width, height: 0.7))
            separator2.backgroundColor = UIColor.label
            tabBar.insertSubview(separator2, at: 0)
        }
    }
//    private func SetNavigationBar(){
//        navigationItem.titleView = nil
//        let searchBtn = UIBarButtonItem(image: UIImage(systemName : "magnifyingglass"), style: .plain, target: self, action: #selector(showsearchbar))
//        navigationItem.leftBarButtonItem = searchBtn
//        var config = UIButton.Configuration.plain()
//        var attributeString = AttributedString(changepercent)
//        attributeString.font = .systemFont(ofSize: 12, weight: .medium)
//        attributeString.foregroundColor = UIColor.systemBlue
//        config.attributedTitle = attributeString
//        config.titleAlignment = .leading
//        config.image = UIImage(named: "profile")
//        config.imagePadding = 8
//        config.imagePlacement = .trailing
//        let realbtn = UIButton(configuration: config)
//        let profileBtn = UIBarButtonItem(customView:realbtn )
//        navigationItem.rightBarButtonItem = profileBtn
//    }
//    func swipeGestureNavigationBar(){
//        let down = UISwipeGestureRecognizer(target: self, action: #selector(showsearchbar))
//        down.direction = .down
//        let swipeup = UISwipeGestureRecognizer(target: self, action: #selector(shownavigationBar))
//        swipeup.direction = .up
//        self.view.addGestureRecognizer(down)
//        self.view.addGestureRecognizer(swipeup)
//    }
//    @objc func shownavigationBar(){
//        SetNavigationBar()
//    }
//    @objc func showsearchbar(){
//        layoutSearchBar()
//    }
//    func layoutSearchBar(){
//        let searchbar = UISearchBar()
//        searchbar.placeholder = "검색어를 입력해주세요"
//        searchbar.searchTextField.backgroundColor = .clear
//        navigationItem.leftBarButtonItem = .none
//        navigationItem.rightBarButtonItem = .none
//        self.navigationItem.titleView = searchbar
//        let underline3 = UnderlineView()
//        navigationItem.titleView?.addSubview(underline3)
//        underline3.snp.makeConstraints{
//            $0.bottom.equalToSuperview().offset(-8)
//            $0.leading.trailing.equalToSuperview().inset(15)
//            $0.height.equalTo(1.5)
//        }
//    }
}
