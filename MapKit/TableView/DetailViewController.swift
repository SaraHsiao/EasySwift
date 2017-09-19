//
//  DetailViewController.swift
//  TableView
//
//  Created by KaFeiDou on 2017/9/17.
//  Copyright © 2017年 KaFeiDou. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    // 在 Area.swift 中，創建一個 struct，將原本的 name、province、part、image、visited，全部包起來，變成一個包
    // 代碼變得比較簡單，乾淨，以後在維護的時候，相對比較便利
    var area:Area!
    
    @IBOutlet weak var lblAreas: UILabel!
    @IBOutlet weak var lblProvinces: UILabel!
    @IBOutlet weak var lblParts: UILabel!
    @IBOutlet weak var areaImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 將 tableViewController 上面的資料顯示在 DetailViewController 上面
        lblAreas.text = area.name
        lblProvinces.text = area.province
        lblParts.text = area.part
        areaImageView.image = UIImage(named: area.image)
    }
    
}
