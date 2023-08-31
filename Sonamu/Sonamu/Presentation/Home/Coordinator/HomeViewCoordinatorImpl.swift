//
//  HomeViewCoordinatorImpl.swift
//  Sonamu
//
//  Created by Yujin Kim on 2023-08-23.
//

import UIKit

class HomeViewCoordinatorImpl: Coordinator {
	var navigationController: UINavigationController
	var todoViewCoordinator: TodoViewCoordinatorImpl?
	
	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}
	
	func start() {
		let viewController = HomeViewController()
		let catPhotoService = CatPhotoServiceImpl()
		viewController.viewModel = HomeViewModel(catService: catPhotoService)
		viewController.coordinator = self
		navigationController.pushViewController(viewController, animated: false)
	}
	
	func toTodoViewController() {
		let viewController = TodoViewController()
		viewController.viewModel = TodoViewModel()
		todoViewCoordinator = TodoViewCoordinatorImpl(navigationController: navigationController)
		viewController.coordinator = todoViewCoordinator
		navigationController.pushViewController(viewController, animated: true)
	}
	
	func toDoneViewController() {
		let viewController = DoneViewController()
		viewController.viewModel = DoneViewModel()
		navigationController.pushViewController(viewController, animated: true)
	}
}
