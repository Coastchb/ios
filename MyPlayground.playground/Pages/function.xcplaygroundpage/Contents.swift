//: [Previous](@previous)

import Foundation
import Cocoa

// return one value
print("function with one return value:")
func runoob(name: String, age: Int) -> String {
    //name = "coast"    //error: cannot assign to value: 'name' is a 'let' constant (in default, variables in function are const)
    return ("\(name)'s age: \(age)")
}
print(runoob(name: "Coast", age: 28))


// return multiple values (as a tuple)
print("\nfunction with multiple return values:")
func min_max(arr: [Int]) -> (max:Int, min:Int)? {
    if(arr.isEmpty){
        return nil
    }
    var max = arr[0]
    var min = arr[0]
    for v in arr[1..<arr.count] {
        max = v > max ? v : max
        min = v < min ? v : min
    }
    return (max, min)
}

var arr_list = [1,2,3,4,5,6,7]
if let minmax_ret = min_max(arr: arr_list) {
    print("for \(arr_list): max = \(minmax_ret.max); min = \(minmax_ret.min)")
}


// variable parameters
print("\nfunction with variable parameters:")
func var_fun<N>(params: N...) {
    for p in params {
        print(p)
    }
}
var_fun(params: 4,3,2)
var_fun(params: 1.2,3.4)
var_fun(params: "a", "b")


// change the value of parameters and the passed arguments
print("\nchange the value of parameters and the passed arguments:")
func change_params(a: inout Int, b: inout Int) {
    let tmp = a //var tmp = a
    a = b
    b = tmp
}
var x = 10
var y = 100
print("before exchanging: x = \(x); y = \(y)")
change_params(a: &x, b: &y)
print("after exchanging: x = \(x); y = \(y)")


// function type
print("\nfunction type:")
// function type as variable type
func sum(a: Int, b: Int) -> Int {
    return a + b
}
var addition : (Int, Int) -> Int = sum
print(addition(1,2))

// function type as parameters for another function
func minus(a: Int, b: Int) -> Int {
    return a - b
}
func fun1(p_a: (Int, Int) -> Int, p_b: Int, p_c: Int) -> Int {
    if(p_a(p_b,p_c) < 0){
        return minus(a:p_b, b:p_c)
    } else {
        return addition(p_b, p_c)   //or: return sum(a:p_b, b:p_c)
    }
}
print(fun1(p_a: minus, p_b: 0, p_c: 1))
print(fun1(p_a: addition, p_b: 0, p_c: 1))

// function type as return type for another function
func fun2(p_a: Int) -> (Int, Int) -> Int {
    if (p_a < 0) {
        return minus
    } else {
        return addition
    }
}
print(fun2(p_a:-1)(1,2))
print(fun2(p_a:1)(1,2))


// nested function
print("\nnested function:")
func add_mul(a:Int, b:Int, c: Int) -> Int {
    func add(aa:Int, bb:Int) -> Int {
        return aa + bb
    }
    return add(aa:a, bb:b) * c
}
print(add_mul(a:1,b:2,c:3))



// handle error
print("\nhandle error:")
func divide(_ a: Int, _ b: Int) throws -> Int  {
    return a/b
}

do {
    let c = try divide(1,0)
    print("\(c)")
} catch let divError {
    print("Error: \(divError)")
}


