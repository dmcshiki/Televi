//
//  CacheToDomain.swift
//  Televi
//
//  Created by Daniel McCarthy on 12/04/23.
//

import Foundation

extension MovieCM {
    func toDM() -> Movie {
        return Movie(
            id: id,
            name: name,
            image: imageUrl
        )
    }
}

extension MovieInformationCM {
    func toDM(isFavorite: Bool) -> MovieInformation {
        return MovieInformation(
            id: id,
            name: name,
            imageURL: imageUrl,
            isAdultContent: isAdultContent,
            genres: genres,
            overview: overview,
            release_date: release_date,
            score: score,
            isFavorite: isFavorite
        )
    }
}
