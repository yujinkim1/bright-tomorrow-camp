//
//  HomeViewController.swift
//  Sonamu
//
//  Created by Yujin Kim on 2023-08-22.
//

import UIKit

class HomeViewController: BaseUIViewController {
	//MARK: - Coordinator
	weak var coordinator: HomeViewCoordinatorImpl?
	
	//MARK: - ViewModel
	var viewModel: HomeViewModel?
	
	//MARK: - UI Components
	private lazy var tableView: UITableView = {
		let tableView = UITableView()
		tableView.backgroundColor = ColorManager.kErrorColor
		tableView.backgroundView = emptyLabel
		tableView.separatorStyle = .none
		return tableView
	}()
	
	private lazy var emptyLabel: UILabel = {
		let label = UILabel()
		label.textAlignment = .center
		label.textColor = ColorManager.kSecondaryColor
		label.text = viewModel?.setEmptyLiteral()
		return label
	}()
	//TODO: - 나중에 날씨 받아오는거 넣어볼 것
	private lazy var flexibleLabel: UILabel = {
		let label = UILabel()
		label.text = "날씨"
		label.font = UIFont(name: "SUITE-Medium", size: 32.0)
		label.textAlignment = .left
		return label
	}()
	
	private lazy var createTodoButton: UIButton = {
		let button = UIButton(type: .roundedRect)
		button.backgroundColor = .white
		button.setTitle("할 일 추가", for: .normal)
		button.setTitleColor(.black, for: .normal)
		button.titleLabel?.textAlignment = .center
		button.layer.cornerRadius = button.bounds.size.width / 2
		button.clipsToBounds = true
		button.layer.shadowOffset = CGSize(width: 0, height: 4)
		button.layer.shadowColor = UIColor.gray.cgColor
		button.layer.shadowOpacity = 0.5
		button.layer.shadowRadius = CGFloat(8)
		button.layer.masksToBounds = false
		button.isEnabled = true
		return button
	}()
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		tableView.reloadData()
	}
	//MARK: - Custom Method
	
	override func setUI() {
		view.addSubviews([tableView, flexibleLabel, createTodoButton])
	}
	
	override func setLayout() {
		tableView.translatesAutoresizingMaskIntoConstraints = false
		flexibleLabel.translatesAutoresizingMaskIntoConstraints = false
		createTodoButton.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			//tableView(l, t, r, b)
			tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
			tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
			tableView.bottomAnchor.constraint(equalTo: createTodoButton.topAnchor, constant: 0),
			//flexibleLabel(l, t, r, b)
			flexibleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
			flexibleLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
			flexibleLabel.trailingAnchor.constraint(equalTo: createTodoButton.trailingAnchor),
			flexibleLabel.heightAnchor.constraint(equalToConstant: 80),
			//createTodoButton(l, t, r, b, w, h)
			createTodoButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
			createTodoButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
			createTodoButton.heightAnchor.constraint(equalToConstant: 80)
		])
	}
	
	override func setTitle() {
		title = "둘러보기"
	}
	
	override func setDelegate() {
		tableView.register(TodoCell.self, forCellReuseIdentifier: "TodoCell")
		tableView.dataSource = self
		tableView.delegate = self
	}
	
	override func addTarget() {
		createTodoButton.addTarget(self,
								   action: #selector(createTodoButtonTapped(_:)),
								   for: .touchUpInside)
	}
	
	//MARK: - Custom Action
	@objc
	private func createTodoButtonTapped(_ button: UIButton) {
		coordinator?.toCreateTodoViewController()
	}
}

//MARK: - 테이블 뷰
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath) as! TodoCell
		//		let todo = viewModel.decodedTodoGroup[indexPath.row]
		//		cell.configure(with: todo)
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
		let viewController = HomeViewController()
		return UIViewControllerRepresenter(viewController: viewController)
	}
}
#endif
