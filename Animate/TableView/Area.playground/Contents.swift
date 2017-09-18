//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

var areas = ["A級特區","B級特區","C級特區","D級特區","E級特區","F級特區","G級特區","H級特區","I級特區","J級特區","K級特區"]

var address = ["新北市新莊區民安西路70號","桃園縣大園鄉三民路一段785號","新竹市東區中華路二段445號","台南市永康區永明街97號","嘉義市西區上海路147號","高雄市鳳山區鳳北路60之17號","屏東縣麟洛鄉中山路519之5號","宜蘭縣五結鄉五結路三段493號","花蓮縣吉安鄉建國路二段285號","台東縣成功鎮中華路76號","苗栗縣苗栗市玉清路329號"]

var areaImage = ["xinzhuang","qilihe","youxi","chengxi","baiyun","shangjie","nangang","yaodu","wuhou","jinping","furong"]

var provinces = ["上海","甘肅","福建","青海","廣東","福建","黑龍江","山西","四川","廣西","湖南"]

var parts = ["華東","西北","東南","西北","華南","東南","東北","華北","西南","華南","華中"]

var visited = [Bool](repeatElement(false, count: 11))

for i in 0..<areas.count {
    print("Area(name:\"\(areas[i])\", address:\"\(address[i])\",province:\"\(provinces[i])\", part:\"\(parts[i])\", image:\"\(areaImage[i])\", visited:false),")
}
