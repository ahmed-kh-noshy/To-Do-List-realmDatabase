//
//  Item.swift
//  To Do List
//
//  Created by n0shy on 14/06/2023.
//

import Foundation
import RealmSwift


class Item: Object{
    
    @objc dynamic var name: String = ""
    @objc dynamic var checked: Bool = false
    let parent = LinkingObjects(fromType: Category.self, property: "items")
}
