//
//  TableViewController.swift
//  TableView
//
//  Created by KaFeiDou on 2017/9/16.
//  Copyright © 2017年 KaFeiDou. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var areas = ["A級特區","B級特區","C級特區","D級特區","E級特區","F級特區","G級特區","H級特區","I級特區","J級特區","K級特區"]
    
    var areaImage = ["xinzhuang","qilihe","youxi","chengxi","baiyun","shangjie","nangang","yaodu","wuhou","jinping","furong"]
    
    var provinces = ["上海","甘肅","福建","青海","廣東","福建","黑龍江","山西","四川","廣西","湖南"]
    
    var parts = ["華東","西北","東南","西北","華南","東南","東北","華北","西南","華南","華中"]
    
    var visited = [Bool](repeatElement(false, count: 11))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    // MARK: - TableView of DataSources
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return areas.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! TableViewCell
        
        cell.areas.text = areas[indexPath.row]
        cell.provinces.text = provinces[indexPath.row]
        cell.parts.text = parts[indexPath.row]
        
        cell.areasImage.image = UIImage(named: areaImage[indexPath.row])
        cell.areasImage.layer.cornerRadius = cell.areasImage.frame.height / 2
        cell.clipsToBounds = true
        
        cell.accessoryType = visited[indexPath.row] ? .checkmark : .none
        
        return cell
    }
    
    // Hiding Devices StatusBar
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // 在 row 上面，設置一個 delete 方法，系統默認為 en，可以在 info.plist 上面做修改
    // 預要在 row 上面，設置一個 delete 方法時，必須連同想到，數據庫資料也必須刪除，否則系統會崩潰
    // 如果引用 TableViewDelegate 中的 UITableViewRowAction(editActionForRowAt) 去生成 delete，可以省略以下之代碼
    
    // 如果編輯風格，是「刪除」的時候，本身下面 4 項資料，必須 remove，然後使用，delete，來將資料從 tableView 刪掉
    // 或者，可以使用，reloadData()，刷新資料
    // deleteRows(某一行的刷新) & reloadData(整體刷新)，都是刪除的，主要是動畫的感覺不一樣
    /*
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     
     if editingStyle == .delete {
     self.areas.remove(at: indexPath.row)
     self.provinces.remove(at: indexPath.row)
     self.parts.remove(at: indexPath.row)
     self.areaImage.remove(at: indexPath.row)
     sef.visited.remove(at: indexPath.row)
     
     //tableView.deleteRows(at: [indexPath], with: .fade)
     tableView.reloadData()
     
     } else if editingStyle == .insert {
     
     }
     
     }
     */
    
    // MARK: - TableView of Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let alertView = UIAlertController(title: "親愛的", message: "你點擊了\(areas[indexPath.row]),您去過了嗎？", preferredStyle: .actionSheet)
        let okAction = UIAlertAction(title: "YES", style: .destructive) { (okAction) in
            let cell = tableView.cellForRow(at: indexPath)
            cell?.accessoryType = .checkmark
            self.visited[indexPath.row] = true
        }
        let cancelAction = UIAlertAction(title: "NO", style: .cancel) { (cancelAction) in
            let cell = tableView.cellForRow(at: indexPath)
            cell?.accessoryType = .none
        }
        alertView.addAction(okAction)
        alertView.addAction(cancelAction)
        
        self.present(alertView, animated: true, completion: nil)
        
        // 取消，被電擊後的反色狀態
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // 編輯索引行的動作，顯示菜單的一個function，`分享`
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let shareAction = UITableViewRowAction(style: .normal, title: "分享") { (_, indexPath) in
            let alertView = UIAlertController(title: "分享", message: nil, preferredStyle: .alert)
            let FBShare = UIAlertAction(title: "臉書", style: .default, handler: nil)
            let WCShare = UIAlertAction(title: "微信", style: .default, handler: nil)
            let LineShare = UIAlertAction(title: "LINE", style: .default, handler: nil)
            let cancelShare = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            
            alertView.addAction(FBShare)
            alertView.addAction(WCShare)
            alertView.addAction(LineShare)
            alertView.addAction(cancelShare)
            self.present(alertView, animated: true, completion: nil)
        }
        
        // 一般默認顏色是淡灰色，可以改顏色，使用 backgroundColor
        shareAction.backgroundColor = UIColor.orange
        
        // 顯示菜單的一個function，`刪除`
        let deleteAction = UITableViewRowAction(style: .destructive, title: "刪除") { (_, indexPath) in
            
            self.areas.remove(at: indexPath.row)
            self.provinces.remove(at: indexPath.row)
            self.parts.remove(at: indexPath.row)
            self.areaImage.remove(at: indexPath.row)
            self.visited.remove(at: indexPath.row)
            
            // Delete Row From Data Sources
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
        // 顯示菜單的一個function，`置頂`
        // 在 RGB 顏色當中，數字要 ／255，因為，顏色的值是在0～1中間，alpha，是透明度，1 為不透明
        let topAction = UITableViewRowAction(style: .normal, title: "頂置") { (topAction, indexPath) in
        }
        topAction.backgroundColor = UIColor(hue: 245/255, saturation: 199/255, brightness: 221/255, alpha: 1.0)
        
        return [shareAction,deleteAction,topAction]
    }
}
