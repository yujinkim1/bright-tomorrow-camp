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
	
	//MARK: UI Control 메소드
	private func setDoneListTableView() {
		doneListTableView.dataSource = self
		doneListTableView.delegate = self
		setEmptyLabel()
	}
	
	private func setEmptyLabel() {
		let emptyLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
		emptyLabel.font = UIFont.systemFont(ofSize: 20.0)
		emptyLabel.text = "비어있음"
		emptyLabel.textAlignment = .center
		emptyLabel.textColor = .systemGray
		if DataManager.shared.doneList.isEmpty {
			doneListTableView.backgroundView = emptyLabel
			doneListTableView.separatorStyle = .none
		}
		if !DataManager.shared.doneList.isEmpty {
			doneListTableView.backgroundView = nil
			doneListTableView.separatorStyle = .singleLine
		}
	}
	
	//MARK: UI Table View 데이터와 델리게이트
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
	
	@IBOutlet weak var checkboxButton: UIButton!
	@IBAction func touchUpCheckboxButton(_ sender: UIButton) {
		guard let doneListTableView = superview as? UITableView, let indexPath = doneListTableView.indexPath(for: self) else {
			return
		}
		let done = DataManager.shared.doneList[indexPath.row]
		checkboxButton.isSelected.toggle()
		if checkboxButton.isSelected {
			checkboxButton.setImage(UIImage(systemName: "circle"), for: UIControl.State.selected)
			doneListTableView.beginUpdates()
			let todo = Todo(id: done.id, content: done.content, createdTime: DatePrinter.createTime(), isCompleted: false)
			DataManager.shared.todoList.insert(todo, at: todo.id)
			DataManager.shared.doneList.remove(at: indexPath.row)
			doneListTableView.deleteRows(at: [indexPath], with: .automatic)
			print("할 일: \(DataManager.shared.todoList)")
			print("완료된 일: \(DataManager.shared.doneList)")
			doneListTableView.endUpdates()
		}
	}
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
