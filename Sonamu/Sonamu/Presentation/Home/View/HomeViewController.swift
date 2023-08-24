//
//  ViewController.swift
//  Sonamu
//
//  Created by Yujin Kim on 2023-08-22.
//

import UIKit

class HomeViewController: BaseUIViewController {
	var coordinator: HomeViewCoordinatorImpl?
	
	//MARK: - UI Components
	
	private lazy var homeView = UIView()
	
	private lazy var titleLabel: UILabel = {
		let label: UILabel = UILabel()
		label.frame = CGRect(x: 0, y: 0, width: 100, height: 45)
		label.font = UIFont(name: "SUITE-Bold", size: 38.0)
		label.text = "목록"
		label.textAlignment = .left
		return label
	}()
	
	private lazy var addCardButton: UIButton = {
		let button: UIButton = UIButton()
		button.setTitle("추가", for: .normal)
		button.backgroundColor = .black
		return button
	}()
	
	//MARK: - Custom Method
	
	override func setUI() {
		view.addSubview(homeView)
		homeView.addSubviews([titleLabel])
	}
	
	override func setLayout() {
		homeView.translatesAutoresizingMaskIntoConstraints = false
		titleLabel.translatesAutoresizingMaskIntoConstraints = false
		addCardButton.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			//homeView(l, t, r, b)
			homeView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
			homeView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			homeView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
			homeView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
			//titleLabel(l, t, r, b)
			titleLabel.leadingAnchor.constraint(equalTo: homeView.leadingAnchor, constant: 10),
			titleLabel.topAnchor.constraint(equalTo: homeView.topAnchor, constant: 60),
		])
	}
	
	override func addTarget() {
		let swipeToLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeToLeft(_:)))
		swipeToLeftGesture.direction = .left
		view.addGestureRecognizer(swipeToLeftGesture)
	}
	
	//MARK: - Custom Action
	
	@objc
	private func handleSwipeToLeft(_ gestureRecognizer: UISwipeGestureRecognizer) {
		if gestureRecognizer.state == .ended {
			coordinator?.showCreateViewController()
		}
	}
}
