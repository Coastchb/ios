//: [Previous](@previous)

import Foundation
import Cocoa

// class method
print("about class method:")
class Counter {
    var count = 0
    
    func increment() {
        count += 1
    }
    
    func incrementBy(a: Int) {
        count += a
    }
    
    func reset() {
        count = 0
    }
}

let counter = Counter()
counter.increment()
print(counter.count)

counter.incrementBy(a:4)
print(counter.count)

counter.reset()
print(counter.count)

// struct method
print("\nabout struct method:")
struct Area {
    var length: Int = 1
    var width: Int = 1
    
    func get_area() -> Int {
        return length * width
    }
    
    mutating func scaleBy(a:Int) {
        length *= a
        width *= a
        
        print("length=\(self.length)")
        print("width=\(self.width)")
    }
}

var area = Area(length:3, width:5)      // or: var area = Area()
area.scaleBy(a:10)
area.scaleBy(a:100)
print(area.get_area())

// type method
print("\nabout type method:")
class Math {
    class func abs(a:Int) -> Int {
        return a < 0 ? -a : a
    }
    static func abs1(a:Int) -> Int {
        return a < 0 ? -a : a
    }
}
struct absno {
    static func abs(a:Int) -> Int {
        return a < 0 ? -a : a
    }
}

var no = Math.abs(a:-3)
print(no)
var no1 = Math.abs1(a:3)
print(no1)
var no2 = absno.abs(a:10)
print(no2)


