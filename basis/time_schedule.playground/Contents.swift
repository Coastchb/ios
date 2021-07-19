//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

//: A UIKit based Playground for presenting user interface
  
import UIKit

// method 1:
class MyViewController : UIViewController {
    var second = 5
    var timer : Timer?
    
    override func viewDidLoad() {
        // 1.点击按钮开始计时
        self.view.backgroundColor = .white
        let button = UIButton()
        button.frame = CGRect(x:20,y:20,width:100,height:100)
        
        button.addTarget(self, action: #selector(startTimer) , for: .touchUpInside)
        button.backgroundColor = .red
        self.view.addSubview(button)
    }

    // 2.开始计时
    @objc func startTimer() {
        print("开始计时")
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updataSecond), userInfo: nil, repeats: true)
        //调用fire()会立即启动计时器
        timer!.fire()
     }

     // 3.定时操作
    @objc func updataSecond() {
         if second>1 {
            //.........
            second -= 1
         }else {
            print("结束计时")
            stopTimer()
         }
     }

    // 4.停止计时
    func stopTimer() {
        if timer != nil {
            timer!.invalidate() //销毁timer
            timer = nil
         }
     }
    

}

// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()

// method 2:
func startTimer(max: Int) {
   // 定义需要计时的时间
   var timeCount = max
   // 在global线程里创建一个时间源
   let timer = DispatchSource.makeTimerSource(queue: DispatchQueue.global())
   // 设定这个时间源是每秒循环一次，立即开始
   timer.schedule(deadline: .now(), repeating: .seconds(1))
   // 设定时间源的触发事件
   timer.setEventHandler(handler: {
       // 每秒计时一次
       timeCount = timeCount - 1
       // 时间到了取消时间源
       if timeCount <= 0 {
           timer.cancel()
           print("结束")
       }
       // 返回主线程处理一些事件，更新UI等等
       DispatchQueue.main.async {
           print("-------%d",timeCount);
       }
   })
   // 启动时间源
   timer.resume()
}

startTimer(max: 5)
