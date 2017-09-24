//
//  DiscoverViewController.swift
//  TableView
//
//  Created by KaFeiDou on 2017/9/25.
//  Copyright © 2017年 KaFeiDou. All rights reserved.
//

import UIKit
import AVOSCloud

class RecordsViewController: UITableViewController {
    
    var areas:[AVObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // tableView 的屬性代碼
        tableView.rowHeight = 120
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        // 使用 ActivityIndicator，loading 小菊花兒
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.activityIndicatorViewStyle = .gray
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        
        self.view.addSubview(activityIndicator)
        
        getDataFromCloud()
        activityIndicator.stopAnimating()
        
        // 下拉刷新，tableView 有自帶下拉刷新功能
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(self.refreshData), for: .valueChanged)
    }
    
    // 從雲端取回數據，使用`AVQuery`
    func getDataFromCloud(needUpdate:Bool = false) {
        
        let query = AVQuery(className: "Area")
        
        // 將最新，新增的排列在最上面，因為通常新增的時候，後台會有新增的時間
        query.order(byDescending: "createdAt")
        
        // 需要立馬 updated 的時候，cachePolicy 必須設置 ignoreCache
        if needUpdate {
            query.cachePolicy = .ignoreCache
        } else {
            query.cachePolicy = .cacheElseNetwork
            query.maxCacheAge = 2 * 60
            if query.hasCachedResult() {
                print("當前從緩存中查詢結果")
            }
        }
        
        query.findObjectsInBackground { (results, error) in
            if let results = results as? [AVObject] {
                self.areas = results
                
                // 在 iOS 中，更新是 UI 為主線程，後台 是後線程，可以使用下列方法來讓後線程，變主線程
                OperationQueue.main.addOperation {
                    
                    self.refreshControl?.endRefreshing()
                    self.tableView.reloadData()
                }
            } else {
                print(error ?? "取回數據未知錯誤")
            }
        }
    }
    
    // 重新整理數據，改成 true
    func refreshData() {
        getDataFromCloud(needUpdate: true)
    }
    
    // 從雲端取回資料，並更新在 tableView 上面
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return areas.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecordCell", for: indexPath)
        
        let area = areas[indexPath.row]
        cell.textLabel?.text = area["name"] as? String
        
        // 圖片未加載完成之前，使用默認的圖片
        cell.imageView?.image = UIImage(named: "photoalbum")
        
        cell.imageView!.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        cell.imageView!.layer.cornerRadius = 70 / 2
        cell.imageView!.layer.borderColor = UIColor.green.cgColor
        cell.imageView!.layer.borderWidth = 1.0
        cell.imageView!.contentMode = .scaleToFill
        
        cell.imageView!.clipsToBounds = true
        
        cell.textLabel?.font = UIFont.init(name: "Marker Felt", size: 20)
        
        if let imageFile = area["image"] as? AVFile {
            
            imageFile.getDataInBackground({ (data, error) in
                if let data = data {
                    OperationQueue.main.addOperation {
                        cell.imageView?.image = UIImage(data: data)
                    }
                } else {
                    print(error ?? "取回圖片未知錯誤")
                }
            })
        }
        return cell
    }
}
