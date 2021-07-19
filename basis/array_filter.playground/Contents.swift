import UIKit

// array的contains函数，一旦找到符合要求的（返回true）就不再继续查找
var a : [String:String]?
var aa : [String:String]?
var b : [String:String]?
var bb : [String:String]?
a = ["time2": "", "time1": "2020-02-04 12:58:19", "load_type": "init", "user_tags": "[0, 1, 2]", "page_no": "1"]
aa = a // ["time2": "", "time1": "2020-02-04 12:58:19", "load_type": "init", "user_tags": "[0, 1, 2]", "page_no": "1"]
b = ["load_type": "init","time1": "2020-02-04 12:58:19","time2": ""]
bb = ["time1": "2020-02-04 12:58:19"]

if let c = a?.filter({ (key, _) -> Bool in
    print("for key in a: \(key)")
    return !(b?.contains(where: { (key1, _) -> Bool in
        print("\(key)--\(key1):\(key != key1)")
        return key == key1
    }))! ?? false
}) {
    print(c)
}

if let cc = aa?.filter({ (key, _) -> Bool in
    return bb?.contains(where: { (key1, _) -> Bool in
        return key != key1
    }) ?? false
}) {
    print(cc)
}

print(!(b?.contains(where: {(key,_) -> Bool in
    return key == "load_type"
}))!)

var arr_a = [("a","aa","aaa"), ("b", "bb", "bbb")]
var arr_b = [("b","bb","bbb"), ("c", "cc", "ccc")]

print(arr_a.filter({ arg in
    print(arg)
    return arg.0 == "a"
}))

print(arr_a.filter({arg_a -> Bool in
    return !(arr_b.contains(where: {arg_b -> Bool in
        return arg_a.0 == arg_b.0
    }))
}))
