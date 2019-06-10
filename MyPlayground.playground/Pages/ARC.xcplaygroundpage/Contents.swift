//: [Previous](@previous)

import Foundation
import Cocoa

class Person {
    var name:String?
    init(_ n:String) {
        self.name = n
        print("创建一个Person对象")
    }
    deinit {
        print("销毁一个Person对象")
    }
}

var ref1:Person?

var ref2:Person?
var ref3:Person?

ref1 = Person("Coast")
ref2 = ref1
ref3 = ref1

ref3?.name = "coast"
print("\(ref3?.name)")
print("\(ref1?.name!)")

ref1 = nil
ref2 = nil
ref3 = nil
