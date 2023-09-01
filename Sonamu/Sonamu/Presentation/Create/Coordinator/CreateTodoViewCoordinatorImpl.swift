//
//  CreateTodoViewCoordinatorImpl.swift
//  Sonamu
//
//  Created by Yujin Kim on 2023-08-24.
//

import UIKit

class CreateTodoViewCoordinatorImpl: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {}
}
