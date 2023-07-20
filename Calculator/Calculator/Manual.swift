//
//  CalculatorManual.swift
//  Calculator
//
//  Created by Yujin Kim on 2023-07-20.
//

import Foundation

class Manual {
	let on: String = "계산기 켜는 중..."
	let onSuccess: String = "안녕하세요! 저는 귀염뽀짝 계산기입니다."
	let off: String = "계산기 끄는 중..."
	let offSuccess: String = "계산기를 종료했습니다."
	let notice: String = "아래 항목 중 하나를 선택 해주세요."
	let options: String = "(1): 더하기.  (2): 빼기.   (3): 곱하기.   (4): 나누기.  (q): 전원 끄기."
	let hasOne: String = "더하기를 선택했습니다. 두 값을 입력해주세요. (ex: 2, 10)"
	let hasTwo: String = "빼기를 선택했습니다. 두 값을 입력해주세요. (ex: 2, 10)"
	let hasThree: String = "곱하기를 선택했습니다. 두 값을 입력해주세요. (ex: 2, 10)"
	let hasFour: String = "나누기를 선택했습니다. 두 값을 입력해주세요. (ex: 2, 10)"
	let wrongValue: String = "값이 올바르지 않습니다."
}
