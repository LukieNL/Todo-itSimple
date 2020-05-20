//
//  Category.swift
//  Todo-itSimple
//
//  Created by Lucas van Leerdam on 20/05/2020.
//  Copyright © 2020 Lucas van Leerdam. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name : String = ""
    @objc dynamic var color: String = ""
    let items = List<Item>()
}
