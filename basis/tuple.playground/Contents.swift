let t1: (Int, String) = (1, "string 1")
let (i, s) = t1
print(t1)
print(i)
print(s)


let t2: (i:Int, s:String) = (2, "string 2")
print(t2.i)
print(t2.s)


func t_fun() -> (p1:Int, p2:String) { return (3, "string 3")}
let p = t_fun()
print(p.p1)
print(p.p2)


// tmp
import UIKit
import Foundation
var a = "http://localhost:8888/user/feedback?'coastcao'&'aaa'"
print(a)
print(URL(string:a))


var arr = [1,2,3,4]
print(arr[0..<min(arr.count,10)])

arr.append(contentsOf: [11,22])
arr.insert(contentsOf: [33,44], at: 0)

var aa = Array(arr.prefix(20))


var i_array = [1,2,3]
var j_array = ["a", "b","c"]
var k_array = ["aa", "bb", "cc"]
for i in 0..<i_array.count {
    print(i)
}

print(i_array[0..<2])
