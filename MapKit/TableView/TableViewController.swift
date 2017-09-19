//
//  TableViewController.swift
//  TableView
//
//  Created by KaFeiDou on 2017/9/16.
//  Copyright © 2017年 KaFeiDou. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var areas = [
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

    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 將返回按鈕的文字去掉，只保留箭頭 (代碼必須寫在連 navigaionController 上面的)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        // 自動調整 row 的高度，當 label 文字超出可顯示範圍時候使用
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        // 設定 navigationController 的導航條，狀態的顏色 .black 是將顏色設為白色
        self.navigationController?.navigationBar.barStyle = .black
    }
    
     /*
     // 同上面，這是沒有導航條的時候，更改狀態的顏色
     override var preferredStatusBarStyle: UIStatusBarStyle {
     return .lightContent
     }
     */
    
    // MARK: - TableView of DataSources
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return areas.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! TableViewCell
        
        cell.areas.text = areas[indexPath.row].name
        cell.provinces.text = areas[indexPath.row].province
        cell.parts.text = areas[indexPath.row].part
        cell.address.text = areas[indexPath.row].address
        
        cell.areasImage.image = UIImage(named: areas[indexPath.row].image)
        cell.areasImage.layer.cornerRadius = cell.areasImage.frame.height / 2
        cell.clipsToBounds = true
        
        cell.accessoryType = areas[indexPath.row].visited ? .checkmark : .none
        
        return cell
    }
    
    // Hiding Devices StatusBar (false 不隱藏，true 隱藏)
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    // 在 row 上面，設置一個 delete 方法，系統默認為 en，可以在 info.plist 上面做修改
    // 預要在 row 上面，設置一個 delete 方法時，必須連同想到，數據庫資料也必須刪除，否則系統會崩潰
    // 如果引用 TableViewDelegate 中的 UITableViewRowAction(editActionForRowAt) 去生成 delete，可以省略以下之代碼
    
    // 如果編輯風格，是「刪除」的時候，本身下面 4 項資料，必須 remove，然後使用，delete，來將資料從 tableView 刪掉
    // 或者，可以使用，reloadData()，刷新資料
    // deleteRows(某一行的刷新) & reloadData(整體刷新)，都是刪除的，主要是動畫的感覺不一樣
    /* override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     
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
     
     } */
    
    // MARK: - TableView of Delegate
    /*override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
     let alertView = UIAlertController(title: "親愛的", message: "你點擊了\(areas[indexPath.row]),您去過了嗎？", preferredStyle: .actionSheet)
     let okAction = UIAlertAction(title: "YES", style: .destructive) { (okAction) in
     let cell = tableView.cellForRow(at: indexPath)
     cell?.accessoryType = .checkmark
     self.areas[indexPath.row].visited = true
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
     } */
    
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
    
    // 使用 segue 將 tableView 上面的 image 圖，轉到 DetailViewController 上的 imageView
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowAreaDetail" {
            let destination = segue.destination as! DetailTableViewController
            destination.area = areas[tableView.indexPathForSelectedRow!.row]
        }
    }
}
