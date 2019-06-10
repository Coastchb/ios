//: [Previous](@previous)

import Foundation
import Cocoa

// class
print("About class:")
class StudentMarks {
    var mark1 = 1   // if no initial value is provided, then initializers must be provided, which will initialize mark1
    var mark2 = 10
    var mark3 = 100
    lazy var v = someclass()
    
    // if no initializers are provided, then construction will call the default initializer,which takes no arguments and do nothing in fact
    init (mark1:Int, mark2:Int, mark3:Int) {
        self.mark1 = mark1
        self.mark2 = mark2
        self.mark3 = mark3
    }
    
    
    func print_marks() {
        print("mark1=\(self.mark1);makr2=\(self.mark2);mark3=\(mark3); v=\"\(v.name)\"")
    }
}
class someclass {
    var name = "some class name"
}

let s1 = StudentMarks(mark1:1, mark2:10, mark3:100)
s1.print_marks()

let s2 = StudentMarks(mark1:1, mark2:11, mark3:111)
s2.print_marks()

print("s1===s2: \(s1===s2)")


// class and computation attribute
print("\nAbout class and computation attribute:")
class sample {
    var no1 = 0.0, no2 = 0.0
    var length = 300.0, width = 150.0
    
    var middle: (Double, Double) {
        get{
            return (length/2, width/2)
        }
        set(axis){
            no1 = axis.0 - (length/2)
            no2 = axis.1 - (width/2)
        }
    }
}

var result = sample()
print(result.middle)

result.middle = (0.0, 10.0)
print(result.no1)
print(result.no2)


// class and read-only computation attribute
print("\nAbout class and read-only computation attribute:")
class film {
    var name = ""
    var duration = 0.0
    
    var metainfo : [String : String] {
        return [
            "name": self.name,
            "duration": "\(duration)"
        ]
    }
}

var f = film()
f.name = "Avatar"
f.duration = 1.9
print(f.metainfo["name"]!)
print(f.metainfo["duration"]!)


// class and attribute observer
print("\nAbout class and attribute observer:")
class samplepgm {
    var count: Int = 0 {
        willSet(newVal) {
            print("counter:\(newVal)")
        }
        didSet{
            if (count > oldValue) {
                print("counter:\(count - oldValue)")
            }
        }
    }
}
var spgm = samplepgm()
spgm.count = 100
spgm.count = 800
