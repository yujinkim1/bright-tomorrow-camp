//
//  CreateTodoViewModel.swift
//  Sonamu
//
//  Created by Yujin Kim on 2023-08-27.
//

import Foundation

class CreateTodoViewModel {
	
	var decodedTodoGroup: [Todo] = []
	
	func createTodo(with title: String) {
		if let data = UserDefaults.standard.data(forKey: "TodoGroup") {
			do {
				decodedTodoGroup = try JSONDecoder().decode([Todo].self, from: data)
			} catch {
				print(error.localizedDescription)
			}
		}
		let newData = Todo(content: title, isCompleted: false)
		decodedTodoGroup.append(newData)
		do {
			let encodedNewData = try JSONEncoder().encode(decodedTodoGroup)
			UserDefaults.standard.set(encodedNewData, forKey: "TodoGroup")
			print("새로운 해야할 일이 추가되었습니다.")
		} catch {
			print(error.localizedDescription)
		}
	}
}
