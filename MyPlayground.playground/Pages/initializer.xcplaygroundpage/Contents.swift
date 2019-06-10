//: [Previous](@previous)

import Foundation
import Cocoa

struct Rectangle {
    var length: Double
    let breadth: Double
    var area: Double
    var color: String?      // it can be uninitialized in initializers. but if it is a const, then must be initialized
    
    init(fromLength length: Double, fromBreadth breadth: Double) {
        self.length = length
        self.breadth = breadth
        area = length * breadth
    }
    
    init(fromLeng length: Double, fromBread breadth: Double) {  // internal name are the same, but external name are not
        self.length = length
        self.breadth = breadth
        area = length * breadth
    }
    
    init(_ length: Double, _ breadth: Double) {
        self.length = length
        self.breadth = breadth
        area = length * breadth
    }
}

let ar1 = Rectangle(fromLength: 36, fromBreadth: 12)
// let ar1 = Rectangle(length: 36, breadth: 12) // error: must use external names
print("面积为: \(ar1.area)")

let ar2 = Rectangle(fromLeng: 36, fromBread: 12)
print("面积为: \(ar2.area)")

let ar3 = Rectangle(36,12)
print("面积为: \(ar3.area)")




class Cat {
    var name: String
    init() {
        name = "cat"
    }
}

class Tiger: Cat {
    var power: Int
    override init() {
        power = 10          // must be before super.init()
        super.init()        // is mandatory
        name = "tiger"      // must be after super.init()
    }
    
    deinit {
        print("the Tiger object is destoryed now")
    }
}

var t: Tiger? = Tiger()
t = nil         // t must be set as Tiger? or it will fail
