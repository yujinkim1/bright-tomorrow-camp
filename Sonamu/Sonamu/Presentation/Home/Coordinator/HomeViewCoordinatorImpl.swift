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
		viewController.coordinator = self
		navigationController.pushViewController(viewController, animated: false)
	}
	
	func showCreateViewController() {
		let viewController = CreateViewController()
		navigationController.pushViewController(viewController, animated: true)
	}
}
