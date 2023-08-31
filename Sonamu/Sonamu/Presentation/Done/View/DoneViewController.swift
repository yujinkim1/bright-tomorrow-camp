//
//  DoneViewController.swift
//  Sonamu
//
//  Created by Yujin Kim on 2023-08-29.
//

import UIKit

class DoneViewController: BaseUIViewController {
	//MARK: - 뷰 모델
	var viewModel: DoneViewModel?
	
	var decodedDoneGroup: [Done] = []
	
	//MARK: - UI 컴포넌트
	private lazy var tableView: UITableView = {
		let tableView = UITableView(frame: .zero, style: .insetGrouped)
		tableView.backgroundColor = .systemGray6
		tableView.rowHeight = 60
		tableView.separatorStyle = .singleLine
		return tableView
	}()
	
	//MARK: - 커스텀 메소드
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.decodedDoneGroup = viewModel?.loadDoneGroup() ?? []
		tableView.reloadData()
	}
	
	override func setUI() {
		view.addSubview(tableView)
		navigationItem.rightBarButtonItem = editButtonItem
	}
	override func setLayout() {
		tableView.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
			tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
			tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
		])
	}
	
	override func setTitle() {
		title = "완료됨"
	}
	
	override func setDelegate() {
		tableView.register(DoneGroupCell.self, forCellReuseIdentifier: "DoneGroupCell")
		tableView.delegate = self
		tableView.dataSource = self
	}
	
	override func addTarget() {}
}

//MARK: - 테이블 뷰
extension DoneViewController: UITableViewDelegate, UITableViewDataSource {
	override func setEditing(_ editing: Bool, animated: Bool) {
		super.setEditing(editing, animated: animated)
		tableView.setEditing(editing, animated: true)
	}
	
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			decodedDoneGroup = viewModel?.loadDoneGroup() ?? []
			_ = viewModel?.deleteDoneFromDoneGroup(at: indexPath.row)
			tableView.deleteRows(at: [indexPath], with: .fade)
		}
		tableView.reloadData()
	}
	
	func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
		return true
	}
	
	func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
		_ = viewModel?.deleteDoneFromDoneGroup(at: sourceIndexPath.row)
		tableView.reloadData()
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return decodedDoneGroup.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "DoneGroupCell", for: indexPath) as! DoneGroupCell
		let done = decodedDoneGroup[indexPath.row]
		cell.configure(with: done)
		return cell
	}
}
