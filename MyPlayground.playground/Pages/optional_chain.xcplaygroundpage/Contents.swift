//: [Previous](@previous)

import Foundation
import Cocoa

class Person {
    var residence : Residence?
}
class Residence {
    var rooms = [Room]()
    var numOfRooms : Int {
        return rooms.count
    }
    subscript(i:Int) -> Room {
        return rooms[i]
    }
    func printNumOfRooms() {
        print("\(rooms.count)")
    }
    var address: Address?
}
class Room {
    let name : String
    init(n:String) {
        self.name = n
    }
}
class Address {
    var buildingName : String?
    var buildingNum : String?
    var street : String?
    func buildingIdentifier() -> String? {
        if(buildingName != nil){
            return buildingName
        }else if(buildingNum != nil) {
            return buildingNum
        } else {
            return nil
        }
    }
}

var coast = Person()
if let n = coast.residence?.printNumOfRooms()  {
    print("有房间号")
} else {
    print("无房间号")
}

if let r = coast.residence?[0].name {
    print("第一个房间名为:\(r)")
} else {
    print("no room")
}

let coastHouse = Residence()
coastHouse.rooms.append(Room(n:"room 110"))
coastHouse.rooms.append(Room(n:"room 410"))
coast.residence = coastHouse

let coastAdd = Address()
coastAdd.buildingName = "build 0"
coastAdd.buildingNum = "10"
coastAdd.street = "NanShan"
coast.residence?.address = coastAdd

if let st = coast.residence?.address?.street {
    print("street: \(st)")
} else {
    print("no street")
}

var testScores = ["Dave": [86, 82, 84], "Bev": [79, 94, 81]]
testScores["Dave"]?[0] = 91
testScores["Bev"]?[0]+=1
print(testScores["a"]?[0])

