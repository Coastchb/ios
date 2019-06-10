//: [Previous](@previous)

import Cocoa

var str = "Learning Swfit"

if (str.isEmpty) {
    print("the string is empty")
} else {
    print("the string is not empty")
}

var i = 10
str += ",i = \(i)"
print("\"\(str)\"的长度为：\(str.count)")

let strArr = str.characters.split(separator: ",").map(String.init)
print(strArr[0])
print(strArr[1])

for i in str {
    print("\(i) ", terminator: "")
}
print("")

str.append("!")
print(str)

