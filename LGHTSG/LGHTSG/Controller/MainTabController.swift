//
//  MainTabController.swift
//  LGHTSG
//
//  Created by HA on 2023/01/09.
//

import UIKit

class MainTabController: UITabBarController {
    
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        super.viewDidLoad()
        let systemFontAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12.0, weight: .semibold)]
        UITabBarItem.appearance().setTitleTextAttributes(systemFontAttributes, for: .normal)
        let HomeVC = UINavigationController(rootViewController: HomeViewController())
        var config = UIButton.Configuration.plain()
        config.image = UIImage(named: "home")
        HomeVC.tabBarItem.title = "Home"
        HomeVC.tabBarItem.image = UIImage(named: "home")
        let ExploreVC = UINavigationController(rootViewController: ExploreViewController())
        ExploreVC.tabBarItem.title = "Explore"
        ExploreVC.tabBarItem.image = UIImage(named : "compass")
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
}
