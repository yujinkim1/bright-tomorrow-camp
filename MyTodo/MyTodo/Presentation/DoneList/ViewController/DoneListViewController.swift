//
//  DoneListViewController.swift
//  MyTodo
//
//  Created by Yujin Kim on 2023-08-08.
//

import UIKit

class DoneListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
	
	//MARK: Interface Builder 아웃렛
	@IBOutlet weak var doneListTableView: UITableView!
	
	//MARK: UI View 라이프 사이클
	override func viewDidLoad() {
		super.viewDidLoad()
		title = "완료됨"
		setDoneListTableView()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
	}
	
	private func setDoneListTableView() {
		doneListTableView.dataSource = self
		doneListTableView.delegate = self
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return DataManager.shared.doneList.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = doneListTableView.dequeueReusableCell(withIdentifier: "DoneCell", for: indexPath) as! DoneCell
		let done = DataManager.shared.doneList[indexPath.row]
		cell.configure(with: done)
		return cell
	}
	
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			DataManager.shared.doneList.remove(at: indexPath.row)
			doneListTableView.deleteRows(at: [indexPath], with: .fade)
		}
	}
}

//MARK: DoneList에서 사용하는 셀 라이프 사이클
class DoneCell: UITableViewCell {
	
	static let reuseIdentifier = "DoneCell"
	
	@IBOutlet weak var fixedCircleImageView: UIButton!
	@IBOutlet weak var contentLabel: UILabel!
	@IBOutlet weak var dueDateLabel: UILabel!
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
		setDoneCell()
	}
	
	@available(*, unavailable)
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	func setDoneCell() {
		accessoryType = .none
		selectionStyle = .none
	}
	
	func configure(with done: Done) {
		contentLabel.text = done.content
		dueDateLabel.text = done.dueDate
	}
}
