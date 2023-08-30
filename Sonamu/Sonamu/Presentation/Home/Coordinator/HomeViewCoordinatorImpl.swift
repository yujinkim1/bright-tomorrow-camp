//
//  HomeViewCoordinatorImpl.swift
//  Sonamu
//
//  Created by Yujin Kim on 2023-08-23.
//

import UIKit

class HomeViewCoordinatorImpl: Coordinator {
	var navigationController: UINavigationController
	
	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}
	
	func start() {
		let viewController = HomeViewController()
		viewController.viewModel = HomeViewModel()
		viewController.coordinator = self
		navigationController.pushViewController(viewController, animated: false)
	}
	
	//TODO: - TodoViewCoordinatorImpl 코디네이터 클래스로 이동해야함.
	func toCreateTodoViewController() {
		let viewController = CreateTodoViewController()
		viewController.viewModel = CreateTodoViewModel()
		let navigationController = UINavigationController(rootViewController: viewController)
		navigationController.modalPresentationStyle = .fullScreen
		self.navigationController.present(navigationController, animated: true)
	}
	
	//TODO: - TodoViewController ViewModel
	func toTodoViewController() {
		let viewController = TodoViewController()
		//viewController.viewModel = TodoViewModel()
		navigationController.pushViewController(viewController, animated: true)
	}
	
	//TODO: - DoneViewController ViewModel
	func toDoneViewController() {
		let viewController = DoneViewController()
		//viewController.viewModel = DoneViewModel()
		navigationController.pushViewController(viewController, animated: true)
	}
}
