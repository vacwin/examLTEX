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
    private var mainNav: UINavigationController?
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    final func start() {
        self.tabBar = UITabBarController()
        //main page
        let mainPageVC = MainPageViewController()
        mainPageVC.didSelectPost = { [weak self] post in
            self?.showPost(with: post)
        }
        self.mainNav = UINavigationController(rootViewController: mainPageVC)
        self.mainNav?.navigationBar.titleTextAttributes = [.foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)]
        self.mainNav?.tabBarItem = UITabBarItem(
            title: "Лента новостей",
            image: UIImage(systemName: "house"),
            tag: 0
        )
        //favorite
        let favoriteVC = FavoriteViewController()
        favoriteVC.title = "Favorite"
        let favoriteNav = UINavigationController(rootViewController: favoriteVC)
        favoriteNav.tabBarItem = UITabBarItem(
            title: "Profile",
            image: UIImage(systemName: "heart"),
            tag: 1
        )
        //profile
        let profileVC = ProfileViewController()
        profileVC.title = "Profile"
        let profileNav = UINavigationController(rootViewController: profileVC)
        profileNav.tabBarItem = UITabBarItem(
            title: "Profile",
            image: UIImage(systemName: "person"),
            tag: 2
        )
        self.tabBar.viewControllers = [ self.mainNav!, favoriteNav, profileNav]
        self.navigationController.setViewControllers([self.tabBar], animated: false)
        
    }
    
    private func showPost(with post: Post) {
        let postViewController = PostViewController()
        postViewController.title = post.title
        postViewController.hidesBottomBarWhenPushed = true
        self.mainNav?.pushViewController(postViewController, animated: true)
    }
}
