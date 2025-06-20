//
//  AppCoordinator.swift
//  examLTEX
//
//  Created by vacwin on 20.06.2025.
//

import Foundation
import UIKit
class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    final func start() {
        self.showLogin()
    }
    //MARK: - open smth funcs
    final func showLogin() {
        let loginCoordinator = LoginCoordinator(self.navigationController)
        loginCoordinator.onLoginSuccess = { [weak self] in
            //падает из-за отсутствия родителя
            self?.showMain()
        }
        loginCoordinator.start()
    }
    
    final func showMain() {
        let mainCoordinator = MainCoordinator(self.navigationController)
        mainCoordinator.start()
    }
    
    final func showFavorite() {
        
    }
    
    final func showProfile() {
        
    }
}
