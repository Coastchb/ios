//: [Previous](@previous)

import Foundation
import Cocoa

protocol pro_a {
    var marks : Int {get set}
    var result : Bool {get}
    
    func attendance() -> String
    func markssecured() -> String
}
protocol pro_b : pro_a {
    var present : Bool {get set}
    var subject : String {get set}
    var stname : String {get set}
}
class class_c : pro_b {
    var marks = 96
    var result = true
    var present = false
    var subject = "Swift 协议"
    var stname = "Protocols"
    
    func attendance() -> String {
        return "The \(stname) has secured 99% attendance"
    }
    func markssecured() -> String {
        return "\(stname) has scored \(marks)"
    }
}

var studdet = class_c()
studdet.result = false
studdet.stname = "Swift"
studdet.marks = 98

print(studdet.marks)
print(studdet.result)
print(studdet.present)
print(studdet.subject)
print(studdet.stname)
