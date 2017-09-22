//
//  ContentViewController.swift
//  TableView
//
//  Created by KaFeiDou on 2017/9/21.
//  Copyright © 2017年 KaFeiDou. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {
    
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var lblFooter: UILabel!
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var btnDone: UIButton!
    
    
    // 上面三個的 IBOutlet 是直接對應下面三個的變量的
    var index = 0
    var header = ""
    var footer = ""
    var imageName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblHeader.text = header
        lblFooter.text = footer
        imageView.image = UIImage(named: imageName)
        pageControl.currentPage = index
        
        // 只要不是第三個的引導頁，按鈕都是隱藏狀態
        btnDone.isHidden = (index != 2)
        
    }
    
    @IBAction func btnSkip(_ sender: UIButton) {
        
        // 使用者預設的標準，來存儲小型數據
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: "GuiderShow")
        
        self.dismiss(animated: true, completion: nil)
    }
}
