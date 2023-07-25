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

func app() {
	//MARK: 랜덤 금액을 입금
	print(manual.yourName)
	guard let username: String = readLine() else { return }
	var currentCash: Double = deposit.randomCash()
	let user = User(name: username, cash: currentCash, reservedMovie: [])
	//MARK: Run console without debug build
	print(manual.on)
	print(layout.shrink())
	print("\(user.name)님 환영해요!")
	print("현재 잔액: \(user.cash)")
	print(layout.shrink())
	print(manual.selectMenu)
	layout.showMenus()
	while true {
		guard let selected = readLine()?.uppercased() else {
			print("번호가 잘못되었습니다. 다시 선택해주세요.")
			continue
		}
		switch selected {
			case "1":
				layout.showCurrentMovies()
			case "D":
				layout.showCurrentMoviesDetails()
			case "2":
				layout.selectMovie()
			case "3":
				print("준비 중입니다.")
			case "4":
				print("준비 중입니다.")
			case "5":
				print(manual.off)
				break
			default:
				continue
		}
	}
}
