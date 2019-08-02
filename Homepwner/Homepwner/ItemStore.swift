//
//  ItemStore.swift
//  Homepwner
//
//  Created by 操海兵 on 2019/6/30.
//  Copyright © 2019 Coast. All rights reserved.
//

//import Foundation
import UIKit

class ItemStore {
    var allItems = [Item]()
    let itemArchiveURL: URL = {
        let documentDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentDirectories.first!
        return documentDirectory.appendingPathComponent("items.archive")
    }()
    
    @discardableResult func createItems() -> Item {
        let newItem = Item(random: true)
        allItems.append(newItem)
        return newItem
    }
    
    func removeItem(_ item: Item) {
        if let index = allItems.index(of: item) {
            allItems.remove(at: index)
        }
    }
    
    func moveItem(_ from: Int, _ to: Int) {
        if (from == to){
            return
        }
        let tmp = allItems[from]
        allItems.remove(at: from)
        allItems.insert(tmp, at: to)
    }
    
    func saveChanges() -> Bool {
        print("Saving items to \(itemArchiveURL.path)")
        return NSKeyedArchiver.archiveRootObject(allItems, toFile: itemArchiveURL.path)
    }
    
    init() {
        if let archivedItems = NSKeyedUnarchiver.unarchiveObject(withFile: itemArchiveURL.path) as? [Item] {
            allItems = archivedItems
        }
    }
    /*
    init() {
        for _ in 0..<5 {
            createItems()
        }
    }*/
}
