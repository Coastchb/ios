//: [Previous](@previous)

import Foundation
import Cocoa

class Subjects {
    var physics : String
    init(ph: String) {
        self.physics = ph
    }
}
class Chemistry : Subjects {
    var equations : String
    init(_ eq: String, _ ph: String) {
        self.equations = eq
        super.init(ph: ph)
    }
}
class Maths: Subjects {
    var formulea : String
    init(_ fo : String, _ ph: String) {
        self.formulea = fo
        super.init(ph:ph)
    }
}

let sa = [
    Chemistry("固体物理", "赫兹"),
    Maths("流体动力学", "千兆赫"),
    Chemistry("热物理学", "分贝"),
    Maths("天体物理学", "兆赫"),
    Maths("微分方程", "余弦级数")]

var ch_count = 0
var ma_count = 0
for item in sa {
    // judge the type
    if item is Chemistry {
        ch_count += 1
    } else if item is Maths {
        ma_count += 1
    }
    
    // tranform the type
    if let to_item = item as? Chemistry {
        print("化学主题:\(to_item.equations)")
    } else if let to_item = item as? Maths {
        print("数学主题:\(to_item.formulea)")
    }
}

print("Chemistry has \(ch_count) items")
print("Maths has \(ma_count) items")


let str = "32"
print(Int(str)!)
