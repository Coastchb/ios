//
//  webVC.swift
//  Toutiao
//
//  Created by coastcao(操海兵) on 2019/11/15.
//  Copyright © 2019 coastcao(操海兵). All rights reserved.
//

import UIKit
import WebKit

class webVC:  UIViewController,WKUIDelegate,UINavigationControllerDelegate, UIScrollViewDelegate {

    var webView : WKWebView?
    var url_string = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        super.viewDidLoad()
         //self.navigationItem.title = "首页"
        
         //创建配置对象
         let configuration = WKWebViewConfiguration()
         //为WKWebViewController设置偏好设置
         let preference = WKPreferences()
         configuration.preferences = preference
         
         //允许native与js交互
         preference.javaScriptEnabled = true

         //初识化webView
         print("\(UIScreen.main.bounds.width)")
         print("\(self.view.frame.size.width)")
         let webView = WKWebView.init(frame: CGRect(x: 0, y: 64, width: UIScreen.main.bounds.width, height: self.view.frame.size.height - 64))
         
         webView.uiDelegate = self
         webView.contentMode = .scaleAspectFill
         
         // load local html
         //let request = URLRequest.init(url: URL.init(fileURLWithPath: path!))
         
         // load remote html
        print("got url:\(url_string)")
        print("\(URL(string: url_string))")
        print("\(URL(string: "https://html.spec.whatwg.org/"))")
         let request = URLRequest.init(url: URL(string: url_string)!)
         print("request:\(request)")
         
         webView.load(request)
         self.view.addSubview(webView)
         self.webView = webView
         self.webView?.scrollView.delegate = self
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
