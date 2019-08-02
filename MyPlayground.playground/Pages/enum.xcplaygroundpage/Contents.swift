//: [Previous](@previous)

import Foundation
import Cocoa

enum daysOfWeek {
    case Monday
    case Tuesday
    case Wednesday
    case Thursday
    case Friday
    case Saturday
    case Sunday
}

var day1 = daysOfWeek.Monday
day1 = .Friday
print(day1)
//var day2 = .Sunday        // error
//print(day2)

switch day1 {
case .Monday:
    print("day1 is Monday")
default:
    print("day1 is not Monday")
}

enum student {
    case Name(String)
    case Mark(Int, Int, Int)
}

var student1 = student.Name("Coast")
var student2 = student.Mark(1,10,100)

func output(s: student) {
    switch s {
    case .Name(let name):
        print("\(s) is a Name, name=\(name)")
    case .Mark(let m1, let m2, let m3):
        print("\(s) is a Mark, m1=\(m1), m2=\(m2), m3=\(m3)")
    default:
        print("not a student variable")
    }
}

output(s: student1)
output(s: student2)



