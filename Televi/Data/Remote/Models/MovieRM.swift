//
//  MovieRM.swift
//  Televi
//
//  Created by Daniel McCarthy on 16/02/23.
//

import Foundation
import Moya

struct MovieRM: Decodable {
    let id: Int
    let name: String
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case id
        case name = "title"
        case imageURL = "poster_url"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.imageURL = try container.decode(String.self, forKey: .imageURL)
    }
}

