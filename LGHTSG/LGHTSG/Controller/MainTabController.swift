//
//  MainTabController.swift
//  LGHTSG
//
//  Created by HA on 2023/01/09.
//

import UIKit
<<<<<<< Updated upstream
=======
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
>>>>>>> Stashed changes

class MainTabController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}
