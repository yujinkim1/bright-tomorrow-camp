//
//  Launcher.swift
//  Ariabnb
//
//  Created by Yujin Kim on 2023-07-21.
//

import Foundation

let manual = Manual()
let layout = Layout()
let deposit = Deposit()

func launcher() {
	
	print(layout.outline)
	print("* 호텔 예약은 AriaBnB *\n")
	manual.showMenu()
	print(layout.outline)
	print(manual.selectMessage)
	
	while true {
		if let selectNumber: String = readLine(), let option = Int(selectNumber) {
			switch option {
				case 0:
					print("프로그램이 종료되었습니다.")
					break
				case 1:
					let currentCash: String = String(deposit.randomCash())
					print(currentCash)
					continue
				case 2:
					manual.showRoomStatus()
					continue
				default:
					print("잘못된 선택입니다. 다시 선택해주세요.")
					continue
			}
		}
	}
	
}
