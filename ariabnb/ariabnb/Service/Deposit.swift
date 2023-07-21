//
//  Deposit.swift
//  Ariabnb
//
//  Created by Yujin Kim on 2023-07-21.
//

import Foundation

struct Deposit {
	
	func randomCash() -> Int {
		return Int.random(in: 100_000...500_000) / 10_000 * 10_000
	}
	
}
