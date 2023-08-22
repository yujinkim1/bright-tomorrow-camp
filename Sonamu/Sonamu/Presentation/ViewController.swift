//
//  ViewController.swift
//  Sonamu
//
//  Created by Yujin Kim on 2023-08-22.
//

import UIKit

class ViewController: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		if #available(iOS 15.0, *) {
			view.backgroundColor = .systemMint
		} else {
			view.backgroundColor = .systemIndigo
		}
	}
	
}

