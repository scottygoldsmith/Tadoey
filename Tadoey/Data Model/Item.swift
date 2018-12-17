//
//  Item.swift
//  Tadoey
//
//  Created by Scotty Goldsmith on 12/17/18.
//  Copyright © 2018 Scotty Goldsmith. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?
    //Establishes reverse link to CATEGORY.SWIFT file
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
