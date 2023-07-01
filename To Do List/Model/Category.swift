//
//  Category.swift
//  To Do List
//
//  Created by ahmed khaled on 30/06/2023.
//

import Foundation
import RealmSwift

class Category: Object{
    
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
