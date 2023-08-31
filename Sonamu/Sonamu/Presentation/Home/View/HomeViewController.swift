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
	
	//MARK: - UI 컴포넌트
	private lazy var refreshCatPhotoButton: UIBarButtonItem = {
		let barButtonItem = UIBarButtonItem()
		barButtonItem.image = UIImage(systemName: "arrow.clockwise")
		barButtonItem.style = .plain
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
		imageView.image = UIImage(named: "imageNotFoundImage")
		imageView.contentMode = .scaleAspectFit
		imageView.layer.cornerRadius = CGFloat(16)
		imageView.clipsToBounds = true
		return imageView
	}()
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		tableView.reloadData()
	}
	//MARK: - 커스텀 메소드
	
	override func setUI() {
		tableView.register(PushToGroupCell.self, forCellReuseIdentifier: "PushToGroupCell")
		view.addSubviews([catPhotoView, tableView])
		navigationItem.rightBarButtonItem = refreshCatPhotoButton
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
		tableView.dataSource = self
		tableView.delegate = self
	}
	
	override func addTarget() {
		refreshCatPhotoButton.target = self
		refreshCatPhotoButton.action = #selector(refreshCatPhotoButtonTapped(_:))
	}
	
	@objc
	private func refreshCatPhotoButtonTapped(_ button: UIBarButtonItem) {
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
	}
}

//MARK: - 테이블 뷰
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "PushToGroupCell", for: indexPath) as! PushToGroupCell
		if indexPath.section == 0 {
			let number = viewModel?.loadTodoGroupCount() ?? 0
			let title = "해야할 일 확인하기"
			cell.configure(with: title, number: number)
			return cell
		} else {
			let number = viewModel?.loadDoneGroupCount() ?? 0
			let title = "완료한 일 확인하기"
			cell.configure(with: title, number: number)
			return cell
		}
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		switch indexPath.section {
			case 0: coordinator?.toTodoViewController(); print("Coordinator: \(String(describing: coordinator))")
			case 1: coordinator?.toDoneViewController(); print("Coordinator: \(String(describing: coordinator))")
			default: break
		}
	}
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let headerTitleLabel = UILabel(frame: CGRect(x: 15, y: 0, width: tableView.bounds.size.width, height: tableView.sectionHeaderHeight))
		headerTitleLabel.font = UIFont(name: "SUITE-ExtraBold", size: 32.0)
		headerTitleLabel.textColor = ColorManager.kPrimaryColor
		if section == 0 {
			headerTitleLabel.text = "Todo"
		} else if section == 1 {
			headerTitleLabel.text = "Done"
		}
		return headerTitleLabel
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
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
