//
//  TodoViewModel.swift
//  Sonamu
//
//  Created by Yujin Kim on 2023-08-31.
//

import Foundation

class TodoViewModel {
    func loadTodoGroup() -> [Todo] {
        guard let data = UserDefaultsManager.defaults.data(forKey: "TodoGroup") else { return [] }
        do {
            let item = try JSONDecoder().decode([Todo].self, from: data)
            return item
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    func insertTodoGroup(data: Todo, at index: Int) {
        var todoGroup = loadTodoGroup()
        
        todoGroup.insert(data, at: index)
        
        do {
            let data = try JSONEncoder().encode(todoGroup)
            UserDefaultsManager.defaults.set(data , forKey:"TodoGroup")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteTodoFromTodoGroup(at index: Int) -> Todo? {
        var todoGroup = loadTodoGroup()
        
        guard index < todoGroup.count else { return nil }
        
        let deleteData = todoGroup.remove(at: index)
        
        do {
            let data = try JSONEncoder().encode(todoGroup)
            UserDefaultsManager.defaults.set(data, forKey: "TodoGroup")
        } catch {
            print(error.localizedDescription)
        }
        return deleteData
    }
    
    func insertDoneGroup(_ todo: Todo) {
        var todoGroup: [Todo]
        
        if let data = UserDefaultsManager.defaults.data(forKey: "DoneGroup") {
            do {
                todoGroup = try JSONDecoder().decode([Todo].self, from: data)
            } catch {
                print(error.localizedDescription)
                todoGroup = []
            }
        } else {
            todoGroup = []
        }
        todoGroup.append(todo)
        do {
            let data = try JSONEncoder().encode(todoGroup)
            UserDefaultsManager.defaults.set(data, forKey: "DoneGroup")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func moveFromTodoGroupToDoneGroup(at index: Int) {
        guard let moveData = deleteTodoFromTodoGroup(at : index) else { return }
        insertDoneGroup(moveData)
    }
}
