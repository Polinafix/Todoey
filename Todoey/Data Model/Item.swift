//
//  Item.swift
//  Todoey
//
//  Created by Polina Fiksson on 18/12/2017.
//  Copyright © 2017 PolinaFiksson. All rights reserved.
//

import Foundation
//Encodable, Decodable => Codable
class Item: Codable {
    
    var title: String = ""
    var done: Bool = false
}
