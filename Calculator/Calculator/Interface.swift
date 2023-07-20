//
//  CalculatorInterface.swift
//  Calculator
//
//  Created by Yujin Kim on 2023-07-20.
//

import Foundation

struct Interface {
	
	func loading(duration: Double) {
		let miliseconds = UInt32(duration * 1000)
		usleep(miliseconds * 1000)
	}
	
	func formatConvert(_ value: Double) -> String {
		return String(format: "%.0f", value)
	}
	
	func buildLayout(with result: Double) -> String {
		return """
				_____________
							\(formatConvert(result))
				_____________
	  _____________________
	 |  ___ ___ ___   ___  |
	 | | 7 | 8 | 9 | | + | |
	 | |___|___|___| |___| |
	 | | 4 | 5 | 6 | | - | |
	 | |___|___|___| |___| |
	 | | 1 | 2 | 3 | | x | |
	 | |___|___|___| |___| |
	 | | . | 0 | = | | / | |
	 | |___|___|___| |___| |
	 |_____________________|

"""
	}
}
//	 _____________________
//	|  _________________  |
//	| |             \(result) | |
//	| |_________________| |
//	|  ___ ___ ___   ___  |
//	| | 7 | 8 | 9 | | + | |
//	| |___|___|___| |___| |
//	| | 4 | 5 | 6 | | - | |
//	| |___|___|___| |___| |
//	| | 1 | 2 | 3 | | x | |
//	| |___|___|___| |___| |
//	| | . | 0 | = | | / | |
//	| |___|___|___| |___| |
//	|_____________________|
//
