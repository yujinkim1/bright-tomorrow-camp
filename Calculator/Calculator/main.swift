//
//  main.swift
//  Calculator
//
//  Created by Yujin Kim on 2023-07-20.
//
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
