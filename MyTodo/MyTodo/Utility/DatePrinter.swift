//
//  DatePrinter.swift
//  MyTodo
//
//  Created by Yujin Kim on 2023-08-07.
//

import Foundation

class DatePrinter {
	
	static func currentDate() -> String {
		let dateFormatter: DateFormatter = DateFormatter()
		dateFormatter.dateFormat = "MM월 dd일"
		return dateFormatter.string(from: Date())
	}
	
}
