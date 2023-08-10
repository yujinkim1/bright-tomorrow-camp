//
//  Todo.swift
//  MyTodo
//
//  Created by Yujin Kim on 2023-08-07.
//

import Foundation

struct Todo {
	
	let id: Int
	var content: String
	var createdTime: String
	var isCompleted: Bool = false
	
	init(id: Int, content: String, createdTime: String, isCompleted: Bool) {
		self.id = id
		self.content = content
		self.createdTime = createdTime
		self.isCompleted = isCompleted
	}
	
}
