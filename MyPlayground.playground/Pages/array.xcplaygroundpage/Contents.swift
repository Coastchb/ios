//: [Previous](@previous)

import Foundation
import Cocoa

var intarr : [Int] = [1,2,3]

// traverse the array
print("traverse the array:method 1")
for i in intarr {
    print("\(i) ", terminator: "")
}
print("")

print("\ntraverse the array:method 2")
for i in 0..<intarr.count {
    print("intarr[\(i)]=\(intarr[i]);\t", terminator: "")
}
print("")

print("\ntraverse the array:method 3")
var a : [Int] = [1,2,3]
var iter = a.makeIterator()
while let i = iter.next() {
    print(i)
}
print("")

print("\ntraverse the array:method 4 (for string array)")
var strarr : [String] = ["ab", "cd", "ef"]
for (index,value) in strarr.enumerated() {
    print("index at \(index): \(value);\t", terminator: "")
}
print("")


// add value to array
print("\nadd value to array")
intarr.append(4)
intarr += [5]
for i in 0..<intarr.count {
    print("intarr[\(i)]=\(intarr[i]);\t", terminator: "")
}
print("")

// remove value from array
print("\nremove value from array")
intarr.remove(at: 1)
for i in 0..<intarr.count {
    print("intarr[\(i)]=\(intarr[i]);\t", terminator: "")
}
print("")


// is empty ?
print("\nis empty?")
var intarr1 = [Int](repeating:2, count:3)
print("\(intarr1), counts = \(intarr1.count)")
if (intarr1.isEmpty) {
    print("intarr1 is empty")
} else {
    print("intarr1 is not empty")
}

print("intarr1.isEmpty=\(intarr1.isEmpty)")
