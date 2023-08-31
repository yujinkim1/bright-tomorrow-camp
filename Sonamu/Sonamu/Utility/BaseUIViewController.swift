//
//  BaseUIViewController.swift
//  Sonamu
//
//  Created by Yujin Kim on 2023-08-24.
//

import UIKit

class BaseUIViewController: UIViewController {
	//MARK: - 생성자
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemGray6
		hideKeyboardWhenTappedAround()
		setTitle()
		setUI()
		setLayout()
		setDelegate()
		addTarget()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
	}
	
	//MARK: - 커스텀 메소드
	func setTitle() {}
	
	func setUI() {}
	
	func setLayout() {}
	
	func setDelegate() {}
	
	func addTarget() {}
}
