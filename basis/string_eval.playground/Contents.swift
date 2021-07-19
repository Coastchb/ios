//: A UIKit based Playground for presenting user interface
  
import Foundation

var str = "[1,22,3]"

//var value = str.

//var array2:[String] = str.componentsSeparatedByCharactersInSet(NSCharacterSet (charactersInString: "- "))
var addInfo = "District-1   1656-Union-Street   Eureka  707-445-6600"
var getAddress = addInfo.split(separator: " ", omittingEmptySubsequences: true).map(String.init)
print(getAddress)


let stringData = "K01L02M03"
let res = stringData.components(separatedBy: CharacterSet(charactersIn: "KLM"))
print(res)

print(str.components(separatedBy: CharacterSet(charactersIn: ",[]")))
let string = "dots.and-hyphens"
let array = str.components(separatedBy: CharacterSet(charactersIn: ",[]")).filter( { a -> Bool in
    return a.count != 0
}).map({ str -> Int in
    return Int(str)!
})

print(array[0])
/*
extension String {
  func componentsSeperatedByStrings(ss: [String]) -> [String] {
    let inds = ss.flatMap { s in
        (self.range(of: s) as AnyObject). { r in [r.startIndex, r.endIndex] } ?? []
    }
    let ended = [startIndex] + inds + [endIndex]
    let chunks = stride(from: 0, to: ended.count, by: 2)
    let bounds = map(chunks) { i in (ended[i], ended[i+1]) }
    return bounds
      .map { (s, e) in self[s..<e] }
      .filter { sl in !sl.isEmpty }
  }
}

str.componentsSeperatedByStrings(ss: [",", "[", "]"])*/
