//: [Previous](@previous)

import Foundation
import Cocoa

struct studentMarks {
    var mark1: Int
    var mark2: Int
    
}

var s1 = studentMarks(mark1: 1, mark2: 10)
print("\(s1.mark1) - \(s1.mark2)")
var s2 = s1
s2.mark2 = 100
print("\(s2.mark1) - \(s2.mark2)")
print("\(s1.mark1) - \(s1.mark2)")
