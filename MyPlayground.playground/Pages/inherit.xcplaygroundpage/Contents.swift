//: [Previous](@previous)

import Foundation
import Cocoa

class StudentDetails {
    var stname : String
    var mark : Int

    init(name:String,m:Int) {
        self.stname = name
        self.mark = m
    }
    
    func show() {
        print("for student \(self.stname), mark=\(self.mark)")
    }
}

var sd1 = StudentDetails(name:"swift", m:1)
sd1.show()

class Tom : StudentDetails {
    var height = 175
    init(m:Int, h:Int) {           
        super.init(name:"Tom", m: m)
        self.height = h
    }
    
    override func show() {          // "override" is required
        print("for tom, mark=\(self.mark), height=\(self.height)")
    }
}

var tom = Tom(m:100, h:174)
tom.show()
