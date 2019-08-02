//
//  ViewController.swift
//  Buggy
//
//  Created by 操海兵 on 2019/6/27.
//  Copyright © 2019 Coast. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
    //@IBAction func swithToggled(_ sender: UISwitch) {
        print("called buttonTapped")
        // Log sender:
        print("\(sender)")
        // Log the control state:
        //print("is control on? \(sender.isOn)")
        print("function: \(#function) in file \(#file) line: \(#line) column: \(#column) is called")
        print("before calling badMethod()")
        badMethod()
        print("after calling badMethod()")
    }
    
    func badMethod() {
        let array = NSMutableArray()
        for i in 0..<10 {
            array.insert(i, at:i)
        }
        for _ in 0...10 {
            array.removeObject(at: 0)
        }
    }
}

