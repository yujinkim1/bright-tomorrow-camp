//
//  TodoViewCoordinatorImpl.swift
//  Sonamu
//
//  Created by Yujin Kim on 2023-08-31.
//

import UIKit

class TodoViewCoordinatorImpl: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {}
    
    func toCreateTodoViewController() {
        let viewController = CreateTodoViewController()
        viewController.viewModel = CreateTodoViewModel()
        let newNavigationController = UINavigationController(rootViewController: viewController)
        newNavigationController.modalPresentationStyle = .fullScreen
        navigationController.present(newNavigationController, animated: true)
    }
}
