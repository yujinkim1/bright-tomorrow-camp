//
//  HomeViewModel.swift
//  Sonamu
//
//  Created by Yujin Kim on 2023-08-23.
//

import Foundation

class HomeViewModel {
	var decodedTodoGroup: [Todo] = []
	var decodedDoneGroup: [Done] = []
	
	func setEmptyLiteral() -> String {
		if let data = UserDefaults.standard.data(forKey: "TodoGroup"), !data.isEmpty {
			return ""
		} else {
			return "모든 해야할 일이 완료되었습니다."
		}
	}
	
	func loadTodoGroup() -> [Todo] {
		guard let data = UserDefaults.standard.data(forKey: "TodoGroup") else { return decodedTodoGroup }
		do {
			decodedTodoGroup = try JSONDecoder().decode([Todo].self, from: data)
			return decodedTodoGroup
		} catch {
			print("TodoGroup 데이터 디코딩 에러: \(error)")
		}
		return decodedTodoGroup
	}
}
