//
//  Coordinator.swift
//  Sonamu
//
//  Created by Yujin Kim on 2023-08-23.
//

import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    
    func start()
}
