//
//  MovieCM.swift
//  Televi
//
//  Created by Daniel McCarthy on 11/04/23.
//

import Foundation
import SwiftyUserDefaults

struct MovieCM: Codable, DefaultsSerializable {
    let id: Int
    let name: String
    let imageUrl: String
    
    init(id: Int, name: String, imageUrl: String) {
        self.id = id
        self.name = name
        self.imageUrl = imageUrl
    }
}
