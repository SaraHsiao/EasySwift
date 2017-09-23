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
    var isVisited:Bool
    
    var rating = ""     // 這裡直接初始化，就不需要特別的 init 它了
    
    // 這裡使用初始化函式，初始化的用意，主要是，當我們在原本的 struct Area 當中，去添加任何一項的時候，
    // 如果沒有下面的 init 函式，是添加不上去的
    init(name:String, address:String, province:String, part:String, image:String, isVisited:Bool) {
        
        self.name = name
        self.address = address
        self.province = province
        self.part = part
        self.image = image
        self.isVisited = isVisited
    }
}

/*
 - 使用 CoreData
 
 - Entity 實體名稱 -> 相當於 class 或是 struct 的名稱
 - Attribute 屬性 -> 相當於 class 或是 struct 的宣告名稱(row 行`左右方向 `)
 - Type 型別 -> 相當於 class 或是 struct 的宣告型別(String、Int、Bool這些)
 (只有圖片，比較特別，在 CoreData 的 type 中，使用二進制)
 (之前圖片是放在 Assets 中，所以用的是圖片的名稱 String 型別，可以直接被使用 )
 */

/*
 Area(name:"A級特區", address:"新北市新莊區民安西路70號",province:"上海", part:"華東", image:"xinzhuang", visited:false),
 Area(name:"B級特區", address:"桃園縣大園鄉三民路一段785號",province:"甘肅", part:"西北", image:"qilihe", visited:false),
 Area(name:"C級特區", address:"新竹市東區中華路二段445號",province:"福建", part:"東南", image:"youxi", visited:false),
 Area(name:"D級特區", address:"台南市永康區永明街97號",province:"青海", part:"西北", image:"chengxi", visited:false),
 Area(name:"E級特區", address:"嘉義市西區上海路147號",province:"廣東", part:"華南", image:"baiyun", visited:false),
 Area(name:"F級特區", address:"高雄市鳳山區鳳北路60之17號",province:"福建", part:"東南", image:"shangjie", visited:false),
 Area(name:"G級特區", address:"屏東縣麟洛鄉中山路519之5號",province:"黑龍江", part:"東北", image:"nangang", visited:false),
 Area(name:"H級特區", address:"宜蘭縣五結鄉五結路三段493號",province:"山西", part:"華北", image:"yaodu", visited:false),
 Area(name:"I級特區", address:"花蓮縣吉安鄉建國路二段285號",province:"四川", part:"西南", image:"wuhou", visited:false),
 Area(name:"J級特區", address:"台東縣成功鎮中華路76號",province:"廣西", part:"華南", image:"jinping", visited:false),
 Area(name:"K級特區", address:"苗栗縣苗栗市玉清路329號",province:"湖南", part:"華中", image:"furong", visited:false)
 */
