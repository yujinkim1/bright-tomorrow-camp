//
//  Manual.swift
//  Ariabnb
//
//  Created by Yujin Kim on 2023-07-21.
//

import Foundation

struct Manual {
	
	let menu: [String] = [
		"1. 랜덤 금액 지급",
		"2. 호텔 객실 정보 보기",
		"3. 호텔 객실 예약하기",
		"4. 나의 예약 목록 보기",
		"5. 나의 예약 목록 체크인 날짜 순으로 보기",
		"6. 예약 삭제하기",
		"7. 예약 수정하기",
		"8. 나의 입출금 내역 출력하기",
		"9. 나의 잔액 보기",
		"0. 프로그램 종료하기",
	]
	
	let roomStatus: [String] = [
		"~~~~~객실 정보~~~~~",
		"1번 객실 1박: 10000원",
		"2번 객실 1박: 20000원",
		"3번 객실 1박: 30000원",
		"4번 객실 1박: 40000원",
		"5번 객실 1박: 50000원",
	]
	
	let selectMessage: String = "원하시는 기능의 번호를 입력하세요."
	
	func showMenu() {
		menu.forEach { element in
			print(element)
		}
	}
	
	func showRoomStatus() {
		roomStatus.forEach { element in
			print(element)
		}
	}
	
}

