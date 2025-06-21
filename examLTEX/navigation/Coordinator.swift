//
//  Coordinator.swift
//  examLTEX
//
//  Created by vacwin on 20.06.2025.
//

import Foundation
import UIKit
protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    func start()
}
