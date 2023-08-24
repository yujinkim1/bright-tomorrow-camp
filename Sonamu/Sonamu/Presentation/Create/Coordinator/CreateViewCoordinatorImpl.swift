//
//  CreateViewCoordinatorImpl.swift
//  Sonamu
//
//  Created by Yujin Kim on 2023-08-24.
//

import UIKit

class CreateViewCoordinatorImpl: Coordinator {
	var navigationController: UINavigationController
	
	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}
	
	func didFinished() {
		navigationController.popViewController(animated: true)
	}
}
