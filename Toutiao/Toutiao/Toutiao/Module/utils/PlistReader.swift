//
//  PlistReader.swift
//  Toutiao
//
//  Created by coastcao(操海兵) on 2019/9/11.
//  Copyright © 2019 coastcao(操海兵). All rights reserved.
//

import Foundation

class PlistReader {
    func read(fileNamed: String) throws -> [String: Any] {
        let path = Bundle.main.path(forResource: fileNamed, ofType: "plist")
        let plistData = FileManager.default.contents(atPath: path!)
        var format = PropertyListSerialization.PropertyListFormat.xml
        return try PropertyListSerialization.propertyList(from: plistData!,
                                                          options: .mutableContainersAndLeaves,
                                                          format: &format) as! [String: Any]
    }
}
