//: [Previous](@previous)

import Cocoa

// declare an empty dict
var dict1 : [String : Int] = [:]

// add or update value for key
print("add or update value for key in dict:")

// method 1:
dict1["a"] = 1
dict1["b"] = 10
dict1["c"] = 100

dict1["a"] = 11

// method 2:
var old_val = dict1.updateValue(11, forKey: "a")
print("\(old_val)")


// remove key-value pair
print("\nremove key-value pair in dict:")

// method 1:
dict1["b"] = nil
print(dict1)
print("dict1[\"b\"]=\(dict1["b"])")

// method 2:
dict1.removeValue(forKey: "a")
print(dict1)
print("dict1[\"a\"]=\(dict1["a"])")


// traverse dict
print("\ntraverse the dict:")

// method 1:
for (key,value) in dict1 {
    print("dict1[\(key)]=\(dict1[key])")
}
// method 2:
for (index,item) in dict1.enumerated(){  // item is the key-value pair
    print("\(index): \(item), key=\(item.key), value=\(item.value)")
}

dict1["a"] = 10
// get keys and values from dict
print("\nget keys and values from dict")
let keys = [String](dict1.keys)
let values = [Int](dict1.values)
for k in keys {
    print("\(k)")
}
for v in values {
    print("\(v)")
}

print("")
print("dict1 has \(dict1.count) key-value pairs")
print("dict1.isEmpty = \(dict1.isEmpty)")
