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
    private var childCoordinators: [Coordinator] = []
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    final func start() {
        self.showLogin()
    }
    //MARK: - open smth funcs
    final func showLogin() {
        let loginCoordinator = LoginCoordinator(self.navigationController)
        self.childCoordinators.append(loginCoordinator)
        loginCoordinator.onLoginSuccess = { [weak self, weak loginCoordinator] in
            guard let self else { return }
            if let loginCoordinator {
                self.removeChild(loginCoordinator)
            }
            self.showMain()
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
    final func removeChild(_ coordinator: Coordinator) {
        self.childCoordinators.removeAll { $0 === coordinator }
    }
}
