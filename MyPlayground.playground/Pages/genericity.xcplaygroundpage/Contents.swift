//: [Previous](@previous)

import Foundation
import Cocoa

func exchange<T> (_ a: inout T, _ b: inout T) {
    let tmp = a
    a = b
    b = tmp
}

var a = 1, b = 2
exchange(&a,&b)
print("a=\(a) \t b=\(b)")

var aa = 1.1, bb = 2.2
exchange(&aa,&bb)
print("a=\(aa) \t b=\(bb)")

