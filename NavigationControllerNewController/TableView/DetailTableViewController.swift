//
//  DetailTableViewController.swift
//  TableView
//
//  Created by KaFeiDou on 2017/9/17.
//  Copyright © 2017年 KaFeiDou. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController {
    
    var area:Area!
    
    @IBOutlet weak var largeImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 將 TableViewController 的 image 顯示在 DetailTableViewController 上面
        largeImageView.image = UIImage(named: area.image)
        
        // 更換 TableView 的背景顏色
        tableView.backgroundColor = UIColor(white: 0.98, alpha: 1.0)
        
        // 將 TableView 上面用不到的，分格線去除掉
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        // 更改 TableView 上面分格線的顏色
        tableView.separatorColor = UIColor(white: 0.9, alpha: 1.0)
        
        // 點擊過後，將名稱顯示在下一個 navigation 上面的 title
        self.title = area.name
        
        // 自動調整 row 的高度，當 label 文字超出可顯示範圍時候使用
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell") as! DetailViewCell
        
        //更換 cell 的背景顏色，讓 Table 和 Cell 的顏色一致
        cell.backgroundColor = UIColor(white: 0.98, alpha: 1.0)
        
        switch indexPath.row {
        case 0:
            cell.lblField.text = "地區:"
            cell.lblValue.text = area.name
        case 1:
            cell.lblField.text = "省:"
            cell.lblValue.text = area.province
        case 2:
            cell.lblField.text = "地域:"
            cell.lblValue.text = area.part
        case 3:
            cell.lblField.text = "地址:"
            cell.lblValue.text = area.address
        case 4:
            cell.lblField.text = "是否來過:"
            cell.lblValue.text = String(area.visited)
        default:
            break
        }
        return cell
    }
}
