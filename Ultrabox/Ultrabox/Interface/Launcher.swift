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
let authenticate = Authenticate()
var user = User(name: "김유진", cash: deposit.randomCash(), reservedMovie: [])
// MARK: [app]을 실행
func app() {
	// print(manual.auth)
	// guard let user: User = authenticate.setUser() else { return }
	// 기본 텍스트 인터페이스를 표시합니다.
	print(manual.wakeup)
	print(layout.shrink())
	print("\(user.name)님 환영해요!")
	print("보유 금액: \(user.cash)")
	print(layout.shrink())
	layout.showHome()
	// 사용자는 정해진 입력방식을 통해 원하는 기능을 사용할 수 있습니다.
	while true {
		guard let selected = readLine()?.uppercased() else {
			print("번호가 잘못되었습니다. 다시 선택해주세요.")
			continue
		}
		switch selected {
			case "1":
				layout.showCurrentMovies()
			case "2":
				layout.selectMovie()
			case "3":
				layout.showReservedMovies()
			case "4":
				// TODO: 팝콘, 음료 등 구매
				print("푸드 구매")
			case "5":
				print(manual.sleep)
				break
			default:
				continue
		}
	}
}
