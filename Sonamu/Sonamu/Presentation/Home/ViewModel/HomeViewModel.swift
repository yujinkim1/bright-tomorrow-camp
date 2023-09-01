//
//  HomeViewModel.swift
//  Sonamu
//
//  Created by Yujin Kim on 2023-08-23.
//

import Foundation

class HomeViewModel {
    var catService: CatPhotoServiceImpl
    
    init(catService: CatPhotoServiceImpl) {
        self.catService = catService
    }
    
    func loadTodoGroupCount() -> Int {
        return UserDefaultsManager.loadGroup(key: "TodoGroup", type: [Todo].self)?.count ?? 0
    }
    
    func loadDoneGroupCount() -> Int {
        return UserDefaultsManager.loadGroup(key: "DoneGroup", type: [Done].self)?.count ?? 0
    }
}
