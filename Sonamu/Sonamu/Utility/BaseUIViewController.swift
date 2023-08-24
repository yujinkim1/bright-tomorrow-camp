//
//  BaseUIViewController.swift
//  Sonamu
//
//  Created by Yujin Kim on 2023-08-24.
//

import UIKit

class BaseUIViewController: UIViewController {
	//MARK: - 뷰 컨트롤러 생성자
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white //나중에 ColorManager 값으로 대체해야함
		setUI()
		setLayout()
		addTarget()
		setDelegate()
	}
	
	//MARK: - Custom Method
	func setUI() {}
	
	func setLayout() {}
	
	func addTarget() {}
	
	func setDelegate() {}
}
