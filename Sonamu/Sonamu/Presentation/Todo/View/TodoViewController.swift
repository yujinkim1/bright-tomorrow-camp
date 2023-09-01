//
//  TodoViewController.swift
//  Sonamu
//
//  Created by Yujin Kim on 2023-08-29.
//

import UIKit

class TodoViewController: BaseUIViewController {
    //MARK: - 코디네이터
    weak var coordinator: TodoViewCoordinatorImpl?
    
    //MARK: - 뷰 모델
    var viewModel: TodoViewModel?
    
    var decodedTodoGroup: [Todo] = []
    
    //MARK: - UI 컴포넌트
    private lazy var createTodoButtonItem: UIBarButtonItem = {
        let barbuttonItem = UIBarButtonItem()
        barbuttonItem.image = UIImage(systemName: "plus.circle")
        barbuttonItem.style = .plain
        barbuttonItem.isEnabled = true
        return barbuttonItem
    }()
    
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
        self.decodedTodoGroup = viewModel?.loadTodoGroup() ?? []
        tableView.reloadData()
    }
    
    override func setUI() {
        view.addSubview(tableView)
        navigationItem.rightBarButtonItems = [createTodoButtonItem, editButtonItem]
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
        title = "해야할 일"
    }
    
    override func setDelegate() {
        tableView.register(TodoGroupCell.self, forCellReuseIdentifier: "TodoGroupCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func addTarget() {
        createTodoButtonItem.target = self
        createTodoButtonItem.action = #selector(createTodoButtonTapped(_:))
    }
    
    @objc
    private func createTodoButtonTapped(_ button: UIBarButtonItem) {
        coordinator?.toCreateTodoViewController()
    }
}

extension TodoViewController: UITableViewDelegate, UITableViewDataSource {
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            decodedTodoGroup = viewModel?.loadTodoGroup() ?? []
            _ = viewModel?.deleteTodoFromTodoGroup(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let doneAction = UIContextualAction(style: .normal, title: "Done") { (action, view, completionHandler) in
            self.viewModel?.moveFromTodoGroupToDoneGroup(at: indexPath.row)
            self.decodedTodoGroup = self.viewModel?.loadTodoGroup() ?? []
            completionHandler(true)
        }
        doneAction.backgroundColor = .blue
        return UISwipeActionsConfiguration(actions: [doneAction])
    }
    
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedItem = viewModel?.deleteTodoFromTodoGroup(at: sourceIndexPath.row)
        
        if let item = movedItem {
            viewModel?.insertTodoGroup(data: item, at: destinationIndexPath.row)
        }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return decodedTodoGroup.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoGroupCell", for: indexPath) as! TodoGroupCell
        let todo = decodedTodoGroup[indexPath.row]
        cell.configure(with: todo)
        return cell
    }
}
