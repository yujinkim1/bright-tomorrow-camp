//
//  Deposit.swift
//  Ultrabox
//
//  Created by Yujin Kim on 2023-07-25.
//

import Foundation

struct Deposit {
	func randomCash() -> Double {
		let value = Double.random(in: 5.5...15.0)
		return round(value * 10) / 10
	}
}
