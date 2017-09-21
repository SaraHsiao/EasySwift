//
//  TableViewController.swift
//  TableView
//
//  Created by KaFeiDou on 2017/9/16.
//  Copyright © 2017年 KaFeiDou. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController,NSFetchedResultsControllerDelegate {
    
    var areas:[AreaMO] = []
    
    var fetchController:NSFetchedResultsController<AreaMO>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 將返回按鈕的文字去掉，只保留箭頭 (代碼必須寫在連 navigaionController 上面的)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        // 自動調整 row 的高度，當 label 文字超出可顯示範圍時候使用
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        
        fetchAllData2()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        // 設定 navigationController 的導航條，狀態的顏色 .black 是將顏色設為白色
        self.navigationController?.navigationBar.barStyle = .black
        
        //fetchAllData()
        //tableView.reloadData()
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
        
        cell.areasImage.image = UIImage(data: areas[indexPath.row].image as! Data)
        cell.areasImage.layer.cornerRadius = cell.areasImage.frame.height / 2
        cell.areasImage.contentMode = .scaleAspectFill
        
        cell.clipsToBounds = true
        
        cell.accessoryType = areas[indexPath.row].isVisited ? .checkmark : .none
        
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
    
    // 編輯索引行的動作，顯示菜單的一個function `分享`
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
        
        // 顯示菜單的一個function `刪除`
        let deleteAction = UITableViewRowAction(style: .destructive, title: "刪除") { (_, indexPath) in
            
            //self.areas.remove(at: indexPath.row)
            
            // Delete Row From DataSources
            //tableView.deleteRows(at: [indexPath], with: .fade)
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            context.delete(self.fetchController.object(at: indexPath))
            appDelegate.saveContext()
        }
        
        // 顯示菜單的一個function `置頂`
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
    
    @IBAction func goBackTableVC (segue:UIStoryboardSegue) {
        
        self.dismiss(animated: true, completion: nil)
    }
    /* 第一種方法：在 TableView 上面顯示，在 viewDidAppear 調用和 reloadData 出來
     // 獲取已經 add 的資料，資料是在 addViewController 新增，在 tableViewController 顯示
     // fetch 取資料，所以代碼打在 tableViewController 這裡
     func fetchAllData() {
     let appDelegate = UIApplication.shared.delegate as! AppDelegate
     do {
     areas = try appDelegate.persistentContainer.viewContext.fetch(AreaMO.fetchRequest())
     } catch {
     print(error)
     }
     */
    
    // 第二種方法：如果執行會顯示上一次保存的數據，但是新增數據後，表格不會更新
    func fetchAllData2() {
        let request: NSFetchRequest<AreaMO> = AreaMO.fetchRequest()
        let SortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        request.sortDescriptors = [SortDescriptor]
        
        let appDelegte = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegte.persistentContainer.viewContext
        fetchController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchController.delegate = self
        
        do {
            try fetchController.performFetch()
            if let objects = fetchController.fetchedObjects {
                areas = objects
            }
        } catch {
            print(error)
        }
    }
    
    // MARK: - NSFetchResultControllerDelegate
    // 當控制器`開始`處理內容變化時
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
        tableView.beginUpdates()
    }
    
    // 內容發生變更時，更新類型需要進行篩選，最後在同步
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .automatic)
            print("DELETE")
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .automatic)
            print("INSERT")
        case .update:
            tableView.reloadRows(at: [indexPath!], with: .automatic)
            print("UPDATE")
        default:
            tableView.reloadData()
        }
        if  let objects = fetchController.fetchedObjects {
            areas = objects as! [AreaMO]
        }
    }
    
    // 當控制器已經`處理完`內容變更時
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
        tableView.endUpdates()
    }
}
