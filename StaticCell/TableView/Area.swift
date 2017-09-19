//
//  Area.swift
//  TableView
//
//  Created by KaFeiDou on 2017/9/17.
//  Copyright © 2017年 KaFeiDou. All rights reserved.
//

import Foundation

// 使用 struct，只需要給予型別，不需要初始化，效能遠比 class 好
struct Area {
    var name:String
    var address:String
    var province:String
    var part:String
    var image:String
    var visited:Bool
    
    var rating = ""     // 這裡直接初始化，就不需要特別的 init 它了
    
    // 這裡使用初始化函式，初始化的用意，主要是，當我們在原本的 struct Area 當中，去添加任何一項的時候，
    // 如果沒有下面的 init 函式，是添加不上去的
    init(name:String, address:String, province:String, part:String, image:String, visited:Bool) {
        
        self.name = name
        self.address = address
        self.province = province
        self.part = part
        self.image = image
        self.visited = visited
    }
}
