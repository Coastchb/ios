//: Playground - noun: a place where people can play

import Cocoa

var str = "Hello, playground"
print(str)

var i = 2       // a variable
let a = 1 + 2   // a const
i = 10
//a = 4


for x in 0...10{
    print("\(x) ", terminator: "")
}
print("")

for x in 0..<5{
    print("\(x) * 5 = \(x * 5)\t", terminator: "")
}
print("")

var j : Int = 3   // assign data type explicitly
//j = "haha"        // cannot assign "String" value to "Int" variable

// how to get input from user?
//let theInput = readLine()

var name = "Apple"
var site = "apple.com"
print("\(name) official site is:\(site)")

switch(i){
case 1:
    print("i=1")
case 10:
    print("i=10")
    fallthrough
case 100:
    print("i=100")
default:
    print("default case")
}
