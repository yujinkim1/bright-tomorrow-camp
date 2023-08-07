//
//  DatePrinterTest.swift
//  MyTodoTests
//
//  Created by Yujin Kim on 2023-08-07.
//

import XCTest
@testable import MyTodo

final class DatePrinterTest: XCTestCase {
	
	func testDatePrinter() {
		//MARK: Given (Arrange)
		let testCreatedTime = DatePrinter.createTime()
		
		//MARK: When (Act)
		let validCreatedTime = DatePrinter.createTime()
		
		//MARK: Then (Assert)
		XCTAssertEqual(testCreatedTime, validCreatedTime)
	}
	
	func testValidationModel() {
		//MARK: Given (Arrange)
		let testCreatedTime = DatePrinter.createTime()
		
		//MARK: When (Act)
		let validationTodoModel: Todo = Todo(id: 1, content: "테스트 셀", createdTime: DatePrinter.createTime(), isCompleted: false)
		
		//MARK: Then (Assert)
		XCTAssertEqual(testCreatedTime, validationTodoModel.createdTime)
	}

}
