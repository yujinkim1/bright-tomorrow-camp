//
//  DoneViewModel.swift
//  Sonamu
//
//  Created by Yujin Kim on 2023-08-31.
//

import Foundation

class DoneViewModel {
    func loadDoneGroup() -> [Done] {
        guard let data = UserDefaultsManager.defaults.data(forKey: "DoneGroup") else { return [] }
        do {
            let decoded = try JSONDecoder().decode([Done].self, from: data)
            return decoded
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    func deleteDoneFromDoneGroup(at index: Int) -> Done? {
        var doneGroup = loadDoneGroup()
        
        guard index < doneGroup.count else { return nil }
        
        let deleteData = doneGroup.remove(at: index)
        
        do {
            let data = try JSONEncoder().encode(doneGroup)
            UserDefaultsManager.defaults.set(data, forKey: "DoneGroup")
        } catch {
            print(error.localizedDescription)
        }
        return deleteData
    }
}
