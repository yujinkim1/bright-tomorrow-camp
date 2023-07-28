//
//  Launcher.swift
//  Ultrabox
//
//  Created by Yujin Kim on 2023-07-25.
//

import Foundation

let manual = Manual()
let layout = Layout()
let deposit = Deposit()
var user = User(name: "김유진", cash: deposit.randomCash(), reservedMovie: [], snacks: [])
// MARK: [app]을 실행
func app() {
	// 기본 텍스트 인터페이스를 표시합니다.
	print(manual.wakeup)
	print(layout.shrink())
	print("\(user.name)님 환영해요!")
	print("보유 금액: \(user.cash)")
	print(layout.shrink())
	layout.showHome()
	// 사용자는 정해진 입력방식을 통해 원하는 기능을 사용할 수 있습니다.
	while true {
		print(manual.inputLine, terminator: " ")
		guard let selected = readLine()?.uppercased() else {
			print(manual.isWrong)
			continue
		}
		switch selected {
			case "1":
				// 사용자가 1 입력 시 [Layout] 영화 목록을 볼 수 있습니다.
				layout.showCurrentMovies()
			case "2":
				// 사용자가 4 입력 시 [Layout] 예매를 진행할 수 있습니다.
				layout.selectMovie()
			case "3":
				// 사용자가 3 입력 시 [Layout] 최근 구매 내역을 볼 수 있습니다.
				layout.showReservedMovies()
			case "4":
				// 사용자가 4 입력 시 [Layout] 스낵 메뉴가 나타납니다.
				layout.showSnacks()
			case "5":
				print(manual.sleep)
				break
			default:
				continue
		}
	}
}
