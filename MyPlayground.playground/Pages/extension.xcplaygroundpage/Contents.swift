//: [Previous](@previous)

import Foundation
import Cocoa

// extention for computation attribte
print("extention for computation attribte:")
extension Int {
    var add : Int { return self + 100 }
    var sub : Int { return self - 100 }
    var mul : Int { return self * 100 }
    var div : Int { return self / 100 }
}

let a = 3.add
let b = 2.sub
let c = 1.mul
let d = 100.div
print("a=\(a) \t b=\(b) \t c=\(c) \t d=\(d)")


// extention for method
print("\nextention for method:")
extension Int {
    func topics(_ summation: () -> ()) {
        for i in 0..<self {
            summation()
        }
    }
}
4.topics({print("ok")})
3.topics({print("good")})


// extention for initializer
print("\nextention for initializer:")
struct sum {
    var num1 = 100, num2 = 200
}
struct dif {
    var no1 = 200, no2 = 100
}

struct mul {
    var a = sum()
    var b = dif()
}

extension mul {
    init(x:sum, y:dif){
        _ = x.num1 + x.num2
        _ = y.no1 + y.no2
    }
}
 
let aa = sum(num1: 100, num2: 200)
let bb = dif(no1: 200, no2: 100)

let m = mul(x:aa, y:bb)
print("mul sum:\(m.a.num1 + m.a.num2)")

