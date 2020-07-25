//
//  Model.swift
//  ContactsList
//
//  Created by hasher on 25/07/20.
//  Copyright © 2020 Avinash. All rights reserved.
//

import Foundation

struct ContactObject: Decodable {
    var name, email, position, photo: String?
    
    enum CodingKeys: String, CodingKey{
        case name = "name"
        case email = "email"
        case position = "position"
        case photo = "photo"
    }
}
