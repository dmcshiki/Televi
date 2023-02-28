//
//  MovieInformationRM.swift
//  Televi
//
//  Created by Daniel McCarthy on 16/02/23.
//

import Foundation

struct MovieInformationRM: Decodable {
    let id: Int
    let name: String
    let imageURL: String
    let isAdultContent: Bool
    let genres: [String]
    let overview: String
    let release_date: String
    let score: Double
    
    enum CodingKeys: String, CodingKey {
        case id
        case name = "title"
        case imageURL = "poster_url"
        case isAdultContent = "adult"
        case genres
        case overview
        case release_date
        case score = "vote_average"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        imageURL = try container.decode(String.self, forKey: .imageURL)
        isAdultContent = try container.decode(Bool.self, forKey: .isAdultContent)
        genres = try container.decode([String].self, forKey: .genres)
        overview = try container.decode(String.self, forKey: .overview)
        release_date = try container.decode(String.self, forKey: .release_date)
        score = try container.decode(Double.self, forKey: .score)
    }
}
