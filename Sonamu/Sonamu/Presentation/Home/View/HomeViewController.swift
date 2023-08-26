//
//  ViewController.swift
//  Sonamu
//
//  Created by Yujin Kim on 2023-08-22.
//

import UIKit

class HomeViewController: BaseUIViewController {
	//MARK: - ViewModel
	var viewModel: HomeViewModel
	
	//MARK: - UI Components
	
	private lazy var homeView = UIView()
	
	private lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.frame = CGRect(x: 0, y: 0, width: 100, height: 45)
		label.font = UIFont(name: "SUITE-Bold", size: 38.0)
		label.text = "둘러보기"
		label.textAlignment = .left
		return label
	}()
	
	private lazy var tableView: UITableView = {
		let tableView = UITableView()
		return tableView
	}()
	
	private lazy var createButton: UIButton = {
		let button = UIButton()
		button.backgroundColor = .white
		button.setTitle("다이어리 생성하기", for: .normal)
		button.setTitleColor(.black, for: .normal)
		button.titleLabel?.font = UIFont(name: "SUITE-Medium", size: 24.0)
		button.titleLabel?.textAlignment = .center
		button.layer.cornerRadius = CGFloat(30)
		button.layer.shadowOffset = CGSize(width: 0, height: 4)
		button.layer.shadowColor = UIColor.gray.cgColor
		button.layer.shadowOpacity = 0.5
		button.layer.shadowRadius = CGFloat(12)
		button.layer.masksToBounds = false
		button.isEnabled = true
		return button
	}()
	
	//MARK: - Custom Method
	
	override func setUI() {
		view.addSubview(homeView)
		homeView.addSubviews([titleLabel, tableView, createButton])
	}
	
	override func setLayout() {
		homeView.translatesAutoresizingMaskIntoConstraints = false
		titleLabel.translatesAutoresizingMaskIntoConstraints = false
		tableView.translatesAutoresizingMaskIntoConstraints = false
		createButton.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			//homeView(l, t, r, b)
			homeView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
			homeView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			homeView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
			homeView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
			//titleLabel(l, t, r, b)
			titleLabel.leadingAnchor.constraint(equalTo: homeView.leadingAnchor, constant: 10),
			titleLabel.topAnchor.constraint(equalTo: homeView.topAnchor, constant: 60),
			//collectionView(l, t, r, b)
			tableView.leadingAnchor.constraint(equalTo: homeView.leadingAnchor, constant: 0),
			tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0),
			tableView.trailingAnchor.constraint(equalTo: homeView.trailingAnchor, constant: 0),
			tableView.bottomAnchor.constraint(equalTo: createButton.topAnchor, constant: 0),
			//addCardButton(l, t, r, b, w, h)
			createButton.leadingAnchor.constraint(equalTo: homeView.leadingAnchor, constant: 0),
			createButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
			createButton.trailingAnchor.constraint(equalTo: homeView.trailingAnchor, constant: 0),
			createButton.heightAnchor.constraint(equalToConstant: 120)
		])
	}
	
	override func setDelegate() {
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TodoCell")
		tableView.dataSource = self
		tableView.delegate = self
	}
	
	override func addTarget() {
		let swipeToLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeToLeft(_:)))
		swipeToLeftGesture.direction = .left
		view.addGestureRecognizer(swipeToLeftGesture)
		createButton.addTarget(self, action: #selector(showCreateViewController(_:)), for: .touchUpInside)
	}
	
	init(viewModel: HomeViewModel) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
	}
	
	@available(*, unavailable)
	required init?(coder _: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	//MARK: - Custom Action
	
	@objc
	private func handleSwipeToLeft(_ gestureRecognizer: UISwipeGestureRecognizer) {
		if gestureRecognizer.state == .ended {
			viewModel.coordinator?.showCreateViewController()
		}
	}
	
	@objc
	private func showCreateViewController(_ button: UIButton) {
		viewModel.coordinator?.showCreateViewController()
	}
}

//MARK: - 테이블 뷰
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.setNumberOfRowsInSection()
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath) as! TodoCell
		let todo = viewModel.todos[indexPath.row]
		cell.configure(with: todo)
		return cell
	}
}

#if DEBUG && canImport(SwiftUI)
import SwiftUI
private struct UIViewControllerRepresenter: UIViewControllerRepresentable {
	let viewController: UIViewController
	
	func makeUIViewController(context: Context) -> UIViewController {
		return viewController
	}
	
	func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

struct UIViewControllerPreviewViews: PreviewProvider {
	static var previews: some View {
		let viewModel = HomeViewModel()
		let viewController = HomeViewController(viewModel: viewModel)
		return UIViewControllerRepresenter(viewController: viewController)
	}
}
#endif
