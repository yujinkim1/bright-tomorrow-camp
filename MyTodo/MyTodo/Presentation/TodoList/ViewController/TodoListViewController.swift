//
//  TodoListViewController.swift
//  MyTodo
//
//  Created by Yujin Kim on 2023-08-06.
//

import UIKit

class TodoListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	
	//MARK: Interface Builder 아웃렛과 액션
	@IBOutlet weak var todoListTableView: UITableView!
	@IBAction func addTodoButton(_ sender: UIBarButtonItem) {
		let alretController = UIAlertController(title: "추가하기", message: nil, preferredStyle: .alert)
		alretController.addTextField { textField in
			textField.placeholder = "내용 입력하기"
		}
		
		let add = UIAlertAction(title: "추가", style: .default) { _ in
			if let textField = alretController.textFields?.first, let content = textField.text {
				
				let todo = Todo(id: DataManager.shared.todoList.count + 1, content: content, createdTime: DatePrinter.createTime(), isCompleted: false)
				DataManager.shared.todoList.append(todo)
				let indexPath = IndexPath(row: DataManager.shared.todoList.count - 1, section: 0)
				self.todoListTableView.beginUpdates()
				self.todoListTableView.insertRows(at: [indexPath], with: .automatic)
				self.todoListTableView.endUpdates()
				self.setEmptyLabel()
			}
		}
		let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
		alretController.addAction(add)
		alretController.addAction(cancel)
		
		present(alretController, animated: true, completion: nil)
	}
	
	//MARK: UI View 라이프 사이클
	override func viewDidLoad() {
		super.viewDidLoad()
		setTitle()
		setTodoTableView()
		setTestTodo()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
	}
	
	//MARK: UI Control 메소드
	private func setTitle() {
		title = DatePrinter.currentDate()
	}
	
	private func setTodoTableView() {
		todoListTableView.delegate = self
		todoListTableView.dataSource = self
	}
	
	private func setTestTodo() {
		//		DataManager.shared.todoList.append(Todo(id: 1, content: "스위프트 문법 공부하기", createdTime: DatePrinter.createTime(), isCompleted: false))
		setEmptyLabel()
	}
	
	private func updateTodoListStatus(at indexPath: IndexPath, isSelected: Bool) {
		DataManager.shared.todoList[indexPath.row].isCompleted = isSelected
		
		if isSelected {
			let complete = DataManager.shared.todoList.remove(at: indexPath.row)
			DataManager.shared.completedList.append(Completed(id: complete.id, content: complete.content, dueDate: DatePrinter.currentDate(), isCompleted: true))
			let doneIndexPath = IndexPath(row: DataManager.shared.completedList.count - 1, section: 0)
			todoListTableView.beginUpdates()
			todoListTableView.deleteRows(at: [indexPath], with: .automatic)
			todoListTableView.insertRows(at: [doneIndexPath], with: .automatic)
			todoListTableView.endUpdates()
		}
		if !isSelected {
			let undo = DataManager.shared.completedList.remove(at: indexPath.row)
			DataManager.shared.todoList.append(Todo(id: undo.id, content: undo.content, createdTime: DatePrinter.createTime(), isCompleted: false))
			let undoIndexPath = IndexPath(row: DataManager.shared.todoList.count - 1, section: 0)
			todoListTableView.beginUpdates()
			todoListTableView.deleteRows(at: [indexPath], with: .automatic)
			todoListTableView.insertRows(at: [undoIndexPath], with: .automatic)
			todoListTableView.endUpdates()
		}
		setEmptyLabel()
	}
	
	private func setEmptyLabel() {
		let emptyLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
		emptyLabel.text = "모든 해야할 일이 완료됨"
		emptyLabel.textAlignment = .center
		emptyLabel.textColor = .systemGray
		if DataManager.shared.todoList.isEmpty {
			todoListTableView.backgroundView = emptyLabel
			todoListTableView.separatorStyle = .none
		}
		if !DataManager.shared.todoList.isEmpty {
			todoListTableView.backgroundView = nil
			todoListTableView.separatorStyle = .singleLine
		}
	}
	
	//MARK: UI Table View 데이터와 델리게이트
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return DataManager.shared.todoList.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath) as! TodoCell
		let todo = DataManager.shared.todoList[indexPath.row]
		cell.configure(with: todo)
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		updateTodoListStatus(at: indexPath, isSelected: true)
		print(DataManager.shared.completedList)
		print(DataManager.shared.todoList)
	}
	
}

//TODO: TodoListTableView 분리할 것
//class TodoListTableView: UITableViewDelegate, UITableViewDataSource {}

//MARK: TodoList에서 사용하는 셀 라이프 사이클
class TodoCell: UITableViewCell {
	
	static let reuseIdenifier = "TodoCell"
	private var checkboxImage: UIImage!
	
	//MARK: Interface Builder 아웃렛과 액션
	@IBOutlet weak var contentLabel: UILabel!
	@IBOutlet weak var createTimeLabel: UILabel!
	@IBOutlet weak var checkboxButton: UIButton!
	@IBAction func onTapCheckBoxButton(_ sender: UIButton) {
		checkboxButton.isSelected.toggle()
		checkboxButton.setImage(UIImage(systemName: "circle.inset.filled"), for: UIControl.State.selected)
	}
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
		setTodoCell()
	}
	
	@available(*, unavailable)
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	func setTodoCell() {
		accessoryType = .none
		selectionStyle = .default
	}
	
	func configure(with todo: Todo) {
		contentLabel.text = todo.content
		createTimeLabel.text = todo.createdTime
	}
	
}
