//
//  LoginCoordinator.swift
//  examLTEX
//
//  Created by vacwin on 20.06.2025.
//

import Foundation
import UIKit
class LoginCoordinator: Coordinator {
    var navigationController: UINavigationController
    var onLoginSuccess: (() -> Void)?
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let loginVC = LoginViewController()
        loginVC.onLogin = { [weak self] in
            self?.didLogin()
        }
        self.navigationController.setViewControllers(
            [loginVC],
            animated: false
        )
    }
    
    private func didLogin() {
        self.onLoginSuccess?()
    }
}
