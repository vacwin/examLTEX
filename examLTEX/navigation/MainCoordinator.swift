//
//  MainCoordinator.swift
//  examLTEX
//
//  Created by vacwin on 20.06.2025.
//

import Foundation
import UIKit
class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    private var tabBar: UITabBarController!
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    final func start() {
        self.tabBar = UITabBarController()
        //main page
        let homeVC = MainPageViewController()
        homeVC.title = "Home"
        let homeNav = UINavigationController(rootViewController: homeVC)
        homeNav.tabBarItem = UITabBarItem(
            title: "Home",
            image: UIImage(systemName: "house"),
            tag: 0
        )
        //favorite
        let favoriteVC = FavoriteViewController()
        favoriteVC.title = "Favorite"
        let favoriteNav = UINavigationController(rootViewController: favoriteVC)
        favoriteNav.tabBarItem = UITabBarItem(
            title: "Profile",
            image: UIImage(systemName: "person"),
            tag: 1
        )
        //profile
        let profileVC = ProfileViewController()
        profileVC.title = "Profile"
        let profileNav = UINavigationController(rootViewController: profileVC)
        profileNav.tabBarItem = UITabBarItem(
            title: "Profile",
            image: UIImage(systemName: "person"),
            tag: 1
        )
        self.tabBar.viewControllers = [homeNav, favoriteNav, profileNav]
        self.navigationController.setViewControllers([self.tabBar], animated: true)
    }
    
    final func showDetail() {
        
    }
}
