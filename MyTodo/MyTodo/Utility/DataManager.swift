//
//  DataManager.swift
//  MyTodo
//
//  Created by Yujin Kim on 2023-08-08.
//

import Foundation

/// 싱글톤 패턴으로 하나의 인스턴스만 사용 및 유지
class DataManager {
	static let shared = DataManager()
	
	private init() {}
	
	var todoList: [Todo] = []
	var doneList: [Done] = []
}
