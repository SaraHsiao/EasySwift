//
//  AboutViewController.swift
//  TableView
//
//  Created by KaFeiDou on 2017/9/23.
//  Copyright © 2017年 KaFeiDou. All rights reserved.
//

import UIKit

class AboutViewController: UITableViewController {
    
    var sectionTitle = ["評分","關注Sara的GitHub"]
    var sectionContent = [["在App Store上給我評分","建議意見"],["網頁","數據庫","EasySwift"]]
    var link = ["https://github.com/SaraHsiao","https://github.com/SaraHsiao?tab=repositories","https://github.com/SaraHsiao/EasySwift"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 將 TableView 上面用不到的，分格線去除掉，直接拖一個 view 高度 0 也可以
        //tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    //MARK: - UITableViewDataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    // 設置 section 中 cell 的數量
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 2 : 3
    }
    
    // 設置 section 名稱
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section]
    }
    
    // 設置 cell 的內容
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = sectionContent[indexPath.section][indexPath.row]
        
        return cell
    }
    
    // 選擇 section 中的 cell 的方法
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                if let url = URL(string: "http://apple.com/itunes/charts/paid-apps/") {
                    UIApplication.shared.open(url)
                }
            }
        default:
            break
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
