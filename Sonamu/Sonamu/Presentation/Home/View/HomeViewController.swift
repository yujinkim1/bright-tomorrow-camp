//
//  HomeViewController.swift
//  Sonamu
//
//  Created by Yujin Kim on 2023-08-22.
//

import UIKit

class HomeViewController: BaseUIViewController {
	//MARK: - 코디네이터
	weak var coordinator: HomeViewCoordinatorImpl?
	
	//MARK: - 뷰 모델
	var viewModel: HomeViewModel?
	
	//TODO: - Todo 뷰 모델로 이동 해야함
	var decodedTodoGroup: [Todo] = []
	
	//MARK: - UI 컴포넌트
	private lazy var createTodoButton: UIBarButtonItem = {
		let barButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus.circle"), style: .plain, target: self, action: #selector(createTodoButtonTapped(_:)))
		barButtonItem.isEnabled = true
		return barButtonItem
	}()
	
	private lazy var tableView: UITableView = {
		let tableView = UITableView(frame: .zero, style: .insetGrouped)
		tableView.backgroundColor = .systemGray6
		tableView.rowHeight = 100
		tableView.separatorStyle = .singleLine
		tableView.layer.cornerRadius = CGFloat(8)
		return tableView
	}()
	
	private lazy var catPhotoView: UIImageView = {
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFit
		imageView.layer.cornerRadius = CGFloat(16)
		imageView.clipsToBounds = true
		return imageView
	}()
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.decodedTodoGroup = viewModel?.loadTodoGroupItems() ?? []
		catPhotoView.image = UIImage(named: "imageNotFoundImage")
		viewModel?.catService.download { [weak self] (image) in
			DispatchQueue.main.async {
				if let image = image {
					self?.catPhotoView.image = image
				} else {
					print("Failed to download cat image.")
					self?.catPhotoView.image = UIImage(named: "imageNotFoundImage")
				}
			}
		}
		tableView.reloadData()
	}
	//MARK: - Custom Method
	
	override func setUI() {
		view.addSubviews([catPhotoView, tableView])
		navigationItem.rightBarButtonItem = createTodoButton
	}
	
	override func setLayout() {
		catPhotoView.translatesAutoresizingMaskIntoConstraints = false
		tableView.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			catPhotoView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
			catPhotoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			catPhotoView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
			catPhotoView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.4),
			tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
			tableView.topAnchor.constraint(equalTo: catPhotoView.bottomAnchor, constant: 10),
			tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
			tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
		])
	}
	
	override func setTitle() {
		title = "둘러보기"
	}
	
	override func setDelegate() {
		tableView.register(TodoGroupCell.self, forCellReuseIdentifier: "TodoGroupCell")
		tableView.register(DoneGroupCell.self, forCellReuseIdentifier: "DoneGroupCell")
		tableView.dataSource = self
		tableView.delegate = self
	}
	
	override func addTarget() {}
	
	//MARK: - Custom Action
	@objc
	private func createTodoButtonTapped(_ button: UIButton) {
		coordinator?.toCreateTodoViewController()
	}
}

//MARK: - UITableView
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
	//TODO: - TodoViewController / DoneViewController 이동 가능 셀로 변경해야함
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if section == 0 {
			let count = viewModel?.loadTodoGroupItemCount()
			return count ?? 0
		} else {
			let count = viewModel?.loadDoneGroupItemCount()
			return count ?? 0
		}
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if indexPath.section == 0 {
			let cell = tableView.dequeueReusableCell(withIdentifier: "TodoGroupCell", for: indexPath) as! TodoGroupCell
			cell.titleLabel.text = decodedTodoGroup[indexPath.row].content
			return cell
		} else {
			let cell = tableView.dequeueReusableCell(withIdentifier: "DoneGroupCell", for: indexPath) as! DoneGroupCell
			cell.titleLabel.text = "UserDefaults에 저장됨"
			return cell
		}
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		switch indexPath.section {
			case 1: coordinator?.toDoneViewController()
			default: break
		}
	}
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let headerTitleLabel = UILabel(frame: CGRect(x: 15, y: 0, width: tableView.bounds.size.width, height: tableView.sectionHeaderHeight))
		headerTitleLabel.font = UIFont(name: "SUITE-ExtraBold", size: 26.0)
		headerTitleLabel.textColor = ColorManager.kPrimaryColor
		if section == 0 {
			headerTitleLabel.text = "Todo"
		} else if section == 1 {
			headerTitleLabel.text = "Done"
		}
		return headerTitleLabel
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		if section == 0 {
			return "Todo"
		} else if section == 1 {
			return "Done"
		}
		return nil
	}
	
	func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
		if section == 0 {
			return "\(String(describing: viewModel?.loadTodoGroupItemCount()))개의 항목"
		} else if section == 1 {
			return "\(String(describing: viewModel?.loadDoneGroupItemCount()))개의 항목"
		}
		return nil
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 2
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
