import UIKit
import WebKit

class NAHomeViewController2 : UIViewController,WKNavigationDelegate,WKScriptMessageHandler,WKUIDelegate,UINavigationControllerDelegate, UIScrollViewDelegate {
    
    var webView : WKWebView?
    //var content : JSContext?
    var userContentController : WKUserContentController?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "首页"
       
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
        let webView = WKWebView.init(frame: CGRect(x: 0, y: 64, width: UIScreen.main.bounds.width, height: self.view.frame.size.height))
        webView.navigationDelegate = self
        webView.uiDelegate = self

        var html_string="<div><h1 class=\"article-title margin-bottom-20 common-width\">智能客服、水域漂浮物自动清理、“前厅后仓”渠道构建平台，这里有 3 个值得关注的早期项目</h1><div class=\"article-title-icon common-width margin-bottom-40\">"
        webView.loadHTMLString(html_string, baseURL: nil)
        self.view.addSubview(webView)
        self.webView = webView
        self.webView?.scrollView.delegate = self
        
        let userContentController = WKUserContentController()
        configuration.userContentController = userContentController
        userContentController.add(self,name: "getMessage")
        self.userContentController = userContentController
        
        /*
        let btn = UIButton.init(frame: CGRect(x: 100, y: 390, width: 100, height: 50))
        btn.setTitleColor(.black, for: .normal)
        btn.setTitle("oc调用js", for: .normal)
        btn.addTarget(self, action: #selector(btnAction), for: .touchUpInside)
        self.view.addSubview(btn)*/
        
        self.view.backgroundColor = .white
    }
    /*
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.contentOffset = CGPoint(x: (scrollView.contentSize.width - UIScreen.main.bounds.width) / 2, y: scrollView.contentOffset.y)
    }*/
    
    @objc func btnAction() {
        self.webView?.evaluateJavaScript("testInput('123')", completionHandler: { (data
            , error) in
            print(data as Any)
        })
        self.webView?.evaluateJavaScript("testObject('xjf',26)", completionHandler: { (data, err) in
            print("\(String(describing: data)),\(String(describing: err))")
        })
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print("\(message.name)" + "\(message.body)")
//        message.name 方法名
//        message.body 传递的数据
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//        webView.evaluateJavaScript("testA()") { (data, err) in
//            print("\(String(describing: data)),\(String(describing: err))")
//        }
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("\(error)")
    }
    
    
    //MARK:WKUIDelegate
    //此方法作为js的alert方法接口的实现，默认弹出窗口应该只有提示消息，及一个确认按钮，当然可以添加更多按钮以及其他内容，但是并不会起到什么作用
    //点击确认按钮的相应事件，需要执行completionHandler，这样js才能继续执行
    ////参数 message为  js 方法 alert(<message>) 中的<message>
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let alertViewController = UIAlertController(title: "提示", message:message, preferredStyle: UIAlertController.Style.alert)
        alertViewController.addAction(UIAlertAction(title: "确认", style: UIAlertAction.Style.default, handler: { (action) in
            completionHandler()
        }))
        self.present(alertViewController, animated: true, completion: nil)
    }
    
    // confirm
    //作为js中confirm接口的实现，需要有提示信息以及两个相应事件， 确认及取消，并且在completionHandler中回传相应结果，确认返回YES， 取消返回NO
    //参数 message为  js 方法 confirm(<message>) 中的<message>
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        print("ok 0")
        let alertVicwController = UIAlertController(title: "提示", message: message, preferredStyle: UIAlertController.Style.alert)
        alertVicwController.addAction(UIAlertAction(title: "取消", style: UIAlertAction.Style.cancel, handler: { (alertAction) in
            completionHandler(false)
        }))
        alertVicwController.addAction(UIAlertAction(title: "确定", style: UIAlertAction.Style.default, handler: { (alertAction) in
            completionHandler(true)
        }))
        self.present(alertVicwController, animated: true, completion: nil)
    }
    
    // prompt
    //作为js中prompt接口的实现，默认需要有一个输入框一个按钮，点击确认按钮回传输入值
    //当然可以添加多个按钮以及多个输入框，不过completionHandler只有一个参数，如果有多个输入框，需要将多个输入框中的值通过某种方式拼接成一个字符串回传，js接收到之后再做处理
    //参数 prompt 为 prompt(<message>, <defaultValue>);中的<message>
    //参数defaultText 为 prompt(<message>, <defaultValue>);中的 <defaultValue>
    func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
        print("ok 1")
        let alertViewController = UIAlertController(title: prompt, message: "", preferredStyle: UIAlertController.Style.alert)
        alertViewController.addTextField { (textField) in
            textField.text = defaultText
        }
        alertViewController.addAction(UIAlertAction(title: "完成", style: UIAlertAction.Style.default, handler: { (alertAction) in
            completionHandler(alertViewController.textFields![0].text)
        }))
        self.present(alertViewController, animated: true, completion: nil)
    }
}
