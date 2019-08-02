//
//  Item.swift
//  Homepwner
//
//  Created by 操海兵 on 2019/6/30.
//  Copyright © 2019 Coast. All rights reserved.
//

//import Foundation
import UIKit

class Item : NSObject, NSCoding {
    var name: String
    var valueInDollars: Int
    var serialNumber: String?
    var dateCreated: Date
    
    init(n:String, v:Int, s:String?) {
        self.name = n
        self.valueInDollars = v
        self.serialNumber = s
        self.dateCreated = Date()
        
        super.init()
    }
    
    convenience init(random: Bool=false){
        if(random) {
            let adjectives = ["Fluffy", "Rusty", "Shiny"]
            let nouns = ["Bear", "Spork", "Mac"]
            
            var idx = arc4random_uniform(UInt32(adjectives.count))
            let randomAdjective = adjectives[Int(idx)]
            
            idx = arc4random_uniform(UInt32(nouns.count))
            let randomNouns = nouns[Int(idx)]
            
            let randomName = "\(randomAdjective) \(randomNouns)"
            let randomValueNumber = Int(arc4random_uniform(100))
            let randomSerialNumber = UUID().uuidString.components(separatedBy: "-").first!
            
            self.init(n:randomName, v:randomValueNumber, s:randomSerialNumber)
        } else {
            self.init(n:"", v:0, s:nil)
        }
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(valueInDollars, forKey: "valueInDollars")
        aCoder.encode(serialNumber, forKey: "serialNumber")
        aCoder.encode(dateCreated, forKey: "dateCreated")
    }
    
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "name") as! String
        valueInDollars = aDecoder.decodeInteger(forKey: "valueInDollars")
        serialNumber = aDecoder.decodeObject(forKey: "serialNumber") as! String?
        dateCreated = aDecoder.decodeObject(forKey: "dateCreated") as! Date
        super.init()
    }
}
