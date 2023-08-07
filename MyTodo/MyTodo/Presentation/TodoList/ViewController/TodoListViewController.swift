//
//  TodoListViewController.swift
//  MyTodo
//
//  Created by Yujin Kim on 2023-08-06.
//

import UIKit

class TodoListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	
	private var todoList: [Todo] = []
	private var completeList: [Completed] = []
	
	@IBOutlet weak var todoListTableView: UITableView!
	
	@IBAction func addTodoButton(_ sender: UIBarButtonItem) {
		let alretController = UIAlertController(title: "추가하기", message: nil, preferredStyle: .alert)
		alretController.addTextField { textField in
			textField.placeholder = "내용 입력하기"
		}
		
		let add = UIAlertAction(title: "추가", style: .default) { _ in
			if let textField = alretController.textFields?.first, let content = textField.text {
				self.todoList.append(Todo(id: self.todoList.count + 1, content: content, createdTime: DatePrinter.createTime(), isCompleted: false))
				let indexPath = IndexPath(row: self.todoList.count - 1, section: 0)
				self.todoListTableView.beginUpdates()
				self.todoListTableView.insertRows(at: [indexPath], with: .automatic)
				self.todoListTableView.endUpdates()
			}
		}
		let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
		alretController.addAction(add)
		alretController.addAction(cancel)
		
		present(alretController, animated: true, completion: nil)
	}
	
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
	
	private func setTitle() {
		title = DatePrinter.currentDate()
	}
	
	private func setTodoTableView() {
		todoListTableView.delegate = self
		todoListTableView.dataSource = self
	}

	private func setTestTodo() {
		self.todoList = [
			Todo(
				id: 1,
				content: "테스트 셀입니다.",
				createdTime: DatePrinter.createTime(),
				isCompleted: false
			)
		]
		todoListTableView.reloadData()
	}
	
	private func updateTodoCompletionStatus(at indexPath: IndexPath, isSelected: Bool) {
		todoList[indexPath.row].isCompleted = isSelected
		todoListTableView.reloadRows(at: [indexPath], with: .automatic)
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return todoList.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath) as! TodoCell
		let todo = todoList[indexPath.row]
		cell.configure(with: todo)
		
		cell.checkboxTapHandler = { [weak self] isSelected in
			self?.updateTodoCompletionStatus(at: indexPath, isSelected: isSelected)
		}
		return cell
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		var selected = todoList[indexPath.row]
		selected.isCompleted.toggle()
	}
	
}

//TODO: TodoListTableView 분리할 것
//class TodoListTableView: UITableViewDelegate, UITableViewDataSource {}

//MARK: TodoList에서 사용하는 Cell Life-cycle
class TodoCell: UITableViewCell {
	
	static let reuseIdenifier = "TodoCell"
	private var checkboxImage: UIImageView!
	private var createdTimeLabel: UILabel!
	var checkboxTapHandler: ((Bool) -> Void)?
	
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
		setTodoCell()
		
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(checkboxTapped))
		checkboxImage.addGestureRecognizer(tapGesture)
		checkboxImage.isUserInteractionEnabled = true
	}
	
	@objc private func checkboxTapped() {
		checkboxTapHandler?(isSelected)
	}
	
	@available(*, unavailable)
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	func setTodoCell() {
		accessoryType = .none
		selectionStyle = .default
		createdTimeLabel = UILabel(frame: CGRect(x: 353.0, y: 14.0, width: 353.0, height: 14.0))
		createdTimeLabel.textColor = UIColor.systemGray
		addSubview(createdTimeLabel)
	}
	
	func configure(with todo: Todo) {
		textLabel?.text = todo.content
		imageView?.image = updateCheckboxImage(isCompleted: todo.isCompleted)
		imageView?.tintColor = UIColor.black
		createdTimeLabel?.text = todo.createdTime
	}
	
	func updateCheckboxImage(isCompleted: Bool) -> UIImage {
		let image = isCompleted ? "circle.inset.filled" : "circle"
		return UIImage(systemName: image)!
	}

}
