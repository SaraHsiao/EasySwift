//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

var areas = ["A級特區","B級特區","C級特區","D級特區","E級特區","F級特區","G級特區","H級特區","I級特區","J級特區","K級特區"]

var areaImage = ["xinzhuang","qilihe","youxi","chengxi","baiyun","shangjie","nangang","yaodu","wuhou","jinping","furong"]

var provinces = ["上海","甘肅","福建","青海","廣東","福建","黑龍江","山西","四川","廣西","湖南"]

var parts = ["華東","西北","東南","西北","華南","東南","東北","華北","西南","華南","華中"]

var visited = [Bool](repeatElement(false, count: 11))

for i in 0..<areas.count {
    print("Area(name:\"\(areas[i])\", province:\"\(provinces[i])\", part:\"\(parts[i])\", image:\"\(areaImage[i])\", visited:false),")
}
