//
//  Time_utils.swift
//  Toutiao
//
//  Created by coastcao(操海兵) on 2020/2/2.
//  Copyright © 2020 coastcao(操海兵). All rights reserved.
//

import Foundation
import UIKit

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
       }
       // 返回主线程处理一些事件，更新UI等等
       DispatchQueue.main.async {
           print("-------%d",timeCount);
       }
   })
   // 启动时间源
   timer.resume()
}

