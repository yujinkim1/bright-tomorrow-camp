//
//  BaseUIViewController.swift
//  Sonamu
//
//  Created by Yujin Kim on 2023-08-24.
//

import UIKit

class BaseUIViewController: UIViewController {
	//MARK: - View Constructor
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = ColorManager.kBackgroundColor
		hideKeyboardWhenTappedAround()
		setTitle()
		setUI()
		setLayout()
		addTarget()
		setDelegate()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
	}
	
	//MARK: - Custom Method
	func setTitle() {}
	
	func setUI() {}
	
	func setLayout() {}
	
	func addTarget() {}
	
	func setDelegate() {}
}
