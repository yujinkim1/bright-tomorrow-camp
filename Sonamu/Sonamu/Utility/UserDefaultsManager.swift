//
//  UserDefaultsManager.swift
//  Sonamu
//
//  Created by Yujin Kim on 2023-08-29.
//

import Foundation

class UserDefaultsManager {
    static let defaults = UserDefaults.standard
    
    private init() {}
    
    static func loadGroup<T>(key: String, type: T.Type) -> T? where T: Decodable {
        guard let data = UserDefaultsManager.defaults.data(forKey: key) else { return nil }
        do {
            let group = try JSONDecoder().decode(T.self, from: data)
            return group
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
