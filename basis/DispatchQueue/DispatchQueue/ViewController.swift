//
//  ViewController.swift
//  DispatchQueue
//
//  Created by coastcao(操海兵) on 2019/9/21.
//  Copyright © 2019 coastcao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var queue: DispatchQueue = {
        //自定义一个串行队列
        //let d = DispatchQueue.init(label: "serial")
        //自定义一个并发队列, 附加到全局队列中
        let d = DispatchQueue(label: "concurrent", qos: DispatchQoS.default, attributes: DispatchQueue.Attributes.concurrent, target: DispatchQueue.global())
        return d
    }()
    private var group = DispatchGroup()
    
    @IBAction func click_btn(_ sender: UIButton) {
        queue.async(group: group) {
            Thread.sleep(forTimeInterval: 4)
            //print("\(Date())~~  \(Thread.current)--- \(Thread.current.isMainThread) ~~~ [ sleep \(4) ]")
            print("task 0")
        }
        queue.async(group: group) {
            Thread.sleep(forTimeInterval: 3)
            //print("\(Date())~~  \(Thread.current)--- \(Thread.current.isMainThread) ~~~ [ sleep \(3) ]")
            print("task 1")
        }
        queue.async(group: group, qos: DispatchQoS.default, flags: DispatchWorkItemFlags.barrier, execute: {
            //print("\(Date())~~  \(Thread.current)--- \(Thread.current.isMainThread) ~~~ [ sleep \(0) ]")
            print("task 2")
        })
        queue.async(group: group) {
            Thread.sleep(forTimeInterval: 1)
            //print("\(Date())~~  \(Thread.current)--- \(Thread.current.isMainThread) ~~~ [ sleep \(2) ]")
            print("task 3")
        }
        /*
        group.notify(queue: DispatchQueue.main) {
            Thread.sleep(forTimeInterval: 1)
            print("\(Date()) 所有任务完成  \(Thread.current)--- \(Thread.current.isMainThread) ~~~ [ \(999) ]")
        }*/
    }


}

