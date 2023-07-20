//
//  main.swift
//  Calculator
//
//  Created by Yujin Kim on 2023-07-20.
//
/**
 * 스파르타코딩클럽 내일배움캠프 Swift 기초 주차 과제
 * 나만의 계산기를 단계별로 작업하면서 Swift 문법 활용 능력을 향상시킨다.
 * [Manual], [Interface]는 별도로 작업한 내용으로 콘솔 GUI와 관련있는 부분
 * 해결이 필요한 작업
 * [AddOperation], [SubtractOperation], [MultipleOperation], [DividerOperation] 구조체를 하나로 추상화하는 작업
 * 사용자가 입력한 값이 자연수인지 부동소수인지에 따라 결과 값의 표현이 달라져야 하는 작업
 *
 */

import Foundation

let interface = Interface()
let message = Manual()
let add = AddOperation()
let subtract = SubtractOperation()
let multiple = MultipleOperation()
let divide = DivideOperation()
var result: Double = 0.0

func main() {
	print(message.on)
	interface.loading(duration: 3.0)
	print(message.onSuccess)
	print(interface.buildLayout(with: result))
	while true {
		print(message.notice)
		print(message.options)
		guard let selectNumber: String = readLine(), selectNumber.lowercased() != "q" else {
			print(message.off)
			interface.loading(duration: 3.0)
			print(message.offSuccess)
			break
		}
		if let option = Int(selectNumber) {
			switch option {
				case 1:
					print(message.hasOne)
					guard let input = readLine() else {
						print(message.wrongValue)
						continue
					}
					let numbers = input.split(separator: ", ").compactMap{ Double($0) }
					result = add.compute(left: numbers[0], right: numbers[1])
					print(interface.buildLayout(with: result))
				case 2:
					print(message.hasTwo)
					guard let input = readLine() else {
						print(message.wrongValue)
						continue
					}
					let numbers = input.split(separator: ", ").compactMap{ Double($0) }
					result = subtract.compute(left: numbers[0], right: numbers[1])
					print(interface.buildLayout(with: result))
				case 3:
					print(message.hasThree)
					guard let input = readLine() else {
						print(message.wrongValue)
						continue
					}
					let numbers = input.split(separator: ", ").compactMap{ Double($0) }
					result = multiple.compute(left: numbers[0], right: numbers[1])
					print(interface.buildLayout(with: result))
				case 4:
					print(message.hasFour)
					guard let input = readLine() else {
						print(message.wrongValue)
						continue
					}
					let numbers = input.split(separator: ", ").compactMap{ Double($0) }
					result = divide.compute(left: numbers[0], right: numbers[1])
					print(interface.buildLayout(with: result))
				default:
					continue
			}
		}
	}
}
main()
