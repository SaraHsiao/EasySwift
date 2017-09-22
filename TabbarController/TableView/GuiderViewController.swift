//
//  GuiderViewController.swift
//  TableView
//
//  Created by KaFeiDou on 2017/9/21.
//  Copyright © 2017年 KaFeiDou. All rights reserved.
//

import UIKit

class GuiderViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    var headers = ["我是 Header A","我是 Header B","我是 Header C"]
    var images = ["swift","iOS","beginner"]
    var footers = ["我是 Footer A","我是 Footer B","我是 Footer C"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        
        // 創建第一個頁面，設置了翻頁控制器的數據源，startVC 是 ContentViewController
        if let startVC = vc(atIndex: 0) {
            setViewControllers([startVC], direction: .forward, animated: true, completion: nil)
        }
    }
    
    // MARK: - UIPageViewControllerDataSource
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        // 當前控制器，索引 +1 之後，返回下一個控制器
        var index = (viewController as! ContentViewController).index
        index += 1
        
        return vc(atIndex: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        // 當前控制器，索引 -1 之後，返回前一個控制器
        var index = (viewController as! ContentViewController).index
        index -= 1
        
        return vc(atIndex: index)
    }
    
    // 有可能沒有值
    func vc (atIndex: Int) -> ContentViewController? {
        
        // 判斷 index 是否在合理的區間內，使用 if case 語法
        if case 0..<headers.count = atIndex {
            if let contentVC = storyboard?.instantiateViewController(withIdentifier: "ContentController") as? ContentViewController {
                
                contentVC.header = headers[atIndex]
                contentVC.footer = footers[atIndex]
                contentVC.imageName = images[atIndex]
                contentVC.index = atIndex
                
                return contentVC
            }
        }
        return nil
    }
    /*
     // UIPageViewControllerDataSource 有兩個方法來顯示 page 的 `總數`、`起始頁`
     func presentationCount(for: UIPageViewController) -> Int {
     return headers.count
     }
     
     func presentationIndex(for: UIPageViewController) -> Int {
     return 0
     }
     */
}
