//
//  WebViewController.swift
//  TableView
//
//  Created by KaFeiDou on 2017/9/23.
//  Copyright © 2017年 KaFeiDou. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.isHidden = true
        
        // 實例化一個 WKWebView，必須先 import WebKit
        let wkWebView = WKWebView(frame: view.frame)
        
        if let url = URL(string: "http://www.yahoo.com.tw") {
            let request = URLRequest(url: url)
            wkWebView.load(request)
        }
        
        // 避免 view 顯示的時候，最下方被擋住，先 hiddeBottomBarOnPush，在下代碼
        wkWebView.autoresizingMask = [.flexibleHeight]
        
        view.addSubview(wkWebView)
        
        // 在 Xcode9 以後，會自動將 html 整個 block 起來，必須要在 plist.info 裡面開啟
        // App Transfer Security  Settings -> Allow Arbitrary Load -> YES
        if let url = URL(string: "http://www.google.com.tw") {
            let request = URLRequest(url: url)
            
            webView.loadRequest(request)
        }
    }
}
