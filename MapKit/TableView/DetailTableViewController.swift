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
    @IBOutlet weak var btnRactingImage: UIButton!
    
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
    
    // 從評價的 viewController 返回到 DetailTableViewController
    // 這個是 btn 叉叉，直接拉拉到 Exit `ActionSegue` `goBackDetailVCWithSegue`
    // storyboard 是 RactingViewController，因為是直接 Exit 回到 DetailViewController 所以代碼在這裡
    @IBAction func goBackDetailVC(segue:UIStoryboardSegue) {
        
        // 這裡直接初始化，就不需要特別的 init 它了
        let ratingVC = segue.source as! RatingViewController
        
        // 假如 RactingViewController 中n的 rating 是 rating
        // 那麼 area 中的 racting 是 racting
        // 在 DetailViewController 中的 btnRactingImage直接設定為，被選取的評價
        if let rating = ratingVC.rating {
            self.area.rating = rating
            self.btnRactingImage.setImage(UIImage(named: rating), for: .normal)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    // 如果要在 MapViewController 裡面，吃到地址位置的時候，必須在 from 到 destination 設置
    // 要將 area 裡面的東西傳到 MapViewController 的 area 裡面才可以，使用 segue 中的 identifier
    // 轉場到地圖視圖前，傳遞當前區域的實例
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowMap" {
            let destination = segue.destination as! MapViewController
            destination.area = self.area
        }
    }
}
