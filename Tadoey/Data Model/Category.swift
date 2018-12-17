//
//  Category.swift
//  Tadoey
//
//  Created by Scotty Goldsmith on 12/17/18.
//  Copyright © 2018 Scotty Goldsmith. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    //Establishes link to ITEM.SWIFT file
    let items = List<Item>()
}
