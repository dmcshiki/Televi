//
//  movie_information.swift
//  Televi
//
//  Created by Daniel McCarthy on 10/02/23.
//

import Foundation

struct MovieInformation {
    let id: Int
    let name: String
    let imageURL: String
    let isAdultContent: Bool
    let genres: [String]
    let overview: String
    let release_date: String
    let score: Double
    let isFavorite: Bool
}
