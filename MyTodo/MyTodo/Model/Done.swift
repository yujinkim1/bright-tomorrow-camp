//
//  Completed.swift
//  MyTodo
//
//  Created by Yujin Kim on 2023-08-07.
//

import Foundation

struct Done {
	
	let id: Int
	var content: String
	let dueDate: String
	var isCompleted: Bool
	
	init(id: Int, content: String, dueDate: String, isCompleted: Bool) {
		self.id = id
		self.content = content
		self.dueDate = dueDate
		self.isCompleted = isCompleted
	}
	
}
