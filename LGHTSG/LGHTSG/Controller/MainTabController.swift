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
//        let systemFontAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white, .font: UIFont.systemFont(ofSize: 13.0, weight: .semibold)]
//        let unselectcolor = [NSAttributedString.Key.foregroundColor : UIColor.blue, .font: UIFont.systemFont(ofSize: 13.0, weight: .semibold)]
//        // MARK: - 현재 이거 적용 안됨 왜인지 모르겟음.......
//        UITabBarItem.appearance().setTitleTextAttributes(systemFontAttributes, for: .selected)
//        UITabBarItem.appearance().setTitleTextAttributes(unselectcolor, for: .normal)
        
        let tabbarApperance = UITabBarAppearance()
        let tabbaritemappearcne = UITabBarItemAppearance()
        tabbaritemappearcne.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.darkGray, .font: UIFont.systemFont(ofSize: 12.0, weight: .semibold)]
        tabbaritemappearcne.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white, .font: UIFont.systemFont(ofSize: 12.0, weight: .semibold)]
        tabbarApperance.stackedLayoutAppearance = tabbaritemappearcne
        tabBar.standardAppearance = tabbarApperance
        
        let HomeVC = UINavigationController(rootViewController: HomeViewController())
        
        
        HomeVC.tabBarItem.title = "Home"
        HomeVC.tabBarItem.image = UIImage(named: "home2")
        HomeVC.tabBarItem.selectedImage = UIImage(named: "home")
        let ExploreVC = UINavigationController(rootViewController:ExploreViewController())
        ExploreVC.tabBarItem.title = "Explore"
        ExploreVC.tabBarItem.image = UIImage(named : "compass")
        ExploreVC.tabBarItem.selectedImage = UIImage(named: "compass2")
        tabBar.layer.borderColor = UIColor.white.cgColor
        tabBar.clipsToBounds = false

        viewControllers = [HomeVC,ExploreVC]

        addSeparatorToTabBar()
       
        
    }
    private func addSeparatorToTabBar() {
        if tabBar.items != nil{
            let height = (tabBar.bounds).height
            let itemSize = CGSize(
                width: (tabBar.frame.width) / 2,
                height: (tabBar.frame.size.height))
            let xPosition = itemSize.width * CGFloat(1)
            let separator = UIView(frame: CGRect(
                x: xPosition, y: 0, width: 0.7, height: height))
            separator.backgroundColor = UIColor.white
            tabBar.insertSubview(separator, at: 0)
            let separator2 = UIView(frame: CGRect(x: 0, y: 0, width: tabBar.frame.width, height: 0.7))
            separator2.backgroundColor = UIColor.white
            tabBar.insertSubview(separator2, at: 0)
        }
    }
}
