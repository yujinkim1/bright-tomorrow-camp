//
//  Deposit.swift
//  Ultrabox
//
//  Created by Yujin Kim on 2023-07-25.
//

import Foundation

struct Deposit {
	func randomCash() -> Double {
		let value = Double.random(in: 25.0...45.0)
		return round(value * 10) / 10
	}
}
