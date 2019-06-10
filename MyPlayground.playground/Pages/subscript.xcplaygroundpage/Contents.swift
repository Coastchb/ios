//: [Previous](@previous)

import Foundation
import Cocoa

struct subexample {
    var decrementer: Int
     subscript(index: Int) -> Int {
        return decrementer / index
    }
}

var se = subexample(decrementer:100)

print("100 / 9 = \(se[9])")
print("100 / 2 = \(se[2])")

class DayofWeek {
    private var days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Firday", "Saturday", "Sunday"]
    
    subscript(index: Int) -> String {
        get{
            return self.days[index]
        }
        set(newValue) {
            self.days[index] = newValue
        }
    }
}

var day = DayofWeek()
print("day 1 is \(day[0])")
day[2] = "wednesday"
print("day 2 is \(day[2])")


struct Matrix {
    let rows: Int, columns: Int
    var print: [Double]
    
    init(rows:Int, columns:Int) {
        self.rows = rows
        self.columns = columns
        print = Array(repeating: 0.0,count: self.rows * self.columns )
    }
    subscript(row:Int, column:Int) -> Double {
        get{
            return print[column*row + column]
        }
        set {
            print[column*row + column] = newValue
        }
    }
}

var matrix = Matrix(rows:3, columns:4)
print("matrix[2,3] = \(matrix[2,3])")
matrix[1,2] = 10
print("matrix[1,2] = \(matrix[1,2])")


