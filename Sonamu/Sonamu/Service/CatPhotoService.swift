//
//  CatPhotoService.swift
//  Sonamu
//
//  Created by Yujin Kim on 2023-08-30.
//

import UIKit

protocol CatPhotoService {
	var url: String { get set }
	func download(completion: @escaping (UIImage?) -> Void)
}

class CatPhotoServiceImpl: CatPhotoService {
	var url: String = "https://api.thecatapi.com/v1/images/search"
	
	func download(completion: @escaping (UIImage?) -> Void) {
		guard let url = URL(string: url) else {
			print("URL 주소가 올바르지 않습니다.")
			return
		}
		let session = URLSession(configuration: .default)
		session.dataTask(with: url) { (data, response, error) in
			guard error == nil,
				  let data = data,
				  let results = try? JSONDecoder().decode([CatPhoto].self, from: data),
				  let imageUrlString = results.first?.url,
				  let imageUrl = URL(string: imageUrlString),
				  let imageData = try? Data(contentsOf: imageUrl),
				  let uiimage = UIImage(data: imageData) else {
				completion(nil)
				return
			}
			completion(uiimage)
			print("성공적으로 데이터를 가져왔습니다.")
		}.resume()
	}
}
