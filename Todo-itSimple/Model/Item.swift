//
//  Item.swift
//  Todo-itSimple
//
//  Created by Lucas van Leerdam on 20/05/2020.
//  Copyright © 2020 Lucas van Leerdam. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var dateCreated : Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
