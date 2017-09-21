//
//  RatingViewController.swift
//  TableView
//
//  Created by KaFeiDou on 2017/9/18.
//  Copyright © 2017年 KaFeiDou. All rights reserved.
//

import UIKit

class RatingViewController: UIViewController {
    
    @IBOutlet weak var largeImageView: UIImageView!
    @IBOutlet weak var ratingStackView: UIStackView!
    
    var rating:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 設定從 DetailTableViewController 過來的圖，為模糊線亮狀態，使用`UIVisualEffectView
        let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        blurEffectView.frame = view.frame
        largeImageView.addSubview(blurEffectView)
        
        /*  第一種：使用方法：`震盪彈出`
         // 將三個笑臉，用 StackView 包起來，並使用`仿射變形`，預設 scale 0，就是`不顯示`
         // scale 是規模的意思
         ratingStackView.transform = CGAffineTransform(scaleX: 0, y: 0)
         }
         override func viewDidAppear(_ animated: Bool) {
         
         // 將 ratingStackView 的三個笑臉，已震盪的動畫出現在屏幕上面
         UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.5, options: [], animations: {
         self.ratingStackView.transform = CGAffineTransform.identity
         }, completion: nil)
         */
        
        //======================================================================//
        
        /* 第二種方法：`從螢幕下方彈出到指定位置`
         // 設置開始位置，設置原先的位置
         let startPosition = CGAffineTransform(translationX: 0, y: 500)
         let startScale = CGAffineTransform(scaleX: 0, y: 0)
         
         // 將 stackView 轉變為，原先位置去串連開始位置
         ratingStackView.transform = startScale.concatenating(startPosition)
         }
         override func viewDidAppear(_ animated: Bool) {
         
         // 動畫設置 0.8 秒，設置結束位置，設置結束原本位置的特性
         UIView.animate(withDuration: 0.8) {
         let endPosition = CGAffineTransform(translationX: 0, y: 0)
         let endScale = CGAffineTransform.identity
         
         //將 stackView 轉變為，結束位置去串聯結束原本位置的特性
         self.ratingStackView.transform = endPosition.concatenating(endScale)
         }
         */
        //======================================================================//
        
        // 使用 - 第二種方法：
        let startPosition = CGAffineTransform(translationX: 0, y: 500)
        let startScale = CGAffineTransform(scaleX: 0, y: 0)
        ratingStackView.transform = startScale.concatenating(startPosition)
    }
    override func viewDidAppear(_ animated: Bool) {
        self.viewDidDisappear(animated)
        
        UIView.animate(withDuration: 0.3) { 
            let endPosition = CGAffineTransform(translationX: 0, y: 0)
            let endScale = CGAffineTransform.identity
            self.ratingStackView.transform = endPosition.concatenating(endScale)
        }
    }
    @IBAction func btnRating(_ sender: UIButton) {
        
        switch sender.tag {
        case 30:
            rating = "dislike"
        case 50:
            rating = "good"
        case 100:
            rating = "great"
        default:
            break
        }
        performSegue(withIdentifier: "returnDetailView", sender: self)
    }
}
