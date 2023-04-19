//
//  MovieInformationCM.swift
//  Televi
//
//  Created by Daniel McCarthy on 11/04/23.
//

import Foundation
import SwiftyUserDefaults

struct MovieInformationCM: Codable, DefaultsSerializable {
    let id: Int
    let name: String
    let imageUrl: String
    let isAdultContent: Bool
    let genres: [String]
    let overview: String
    let release_date: String
    let score: Double
    
    init(id: Int, name: String, imageUrl: String, isAdultContent: Bool, genres: [String],
         overview: String, release_date: String, score: Double) {
        self.id = id
        self.name = name
        self.imageUrl = imageUrl
        self.isAdultContent = isAdultContent
        self.genres = genres
        self.overview = overview
        self.release_date = release_date
        self.score = score
    }
}
