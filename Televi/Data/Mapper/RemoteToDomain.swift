//
//  RemoteToDomain.swift
//  Televi
//
//  Created by Daniel McCarthy on 16/02/23.
//

import Foundation

extension MovieRM {
    func toDM() -> Movie {
        return Movie(
            id: id,
            name: name,
            image: imageURL
        )
    }
}

extension MovieInformationRM {
    func toDM() -> MovieInformation {
        return MovieInformation(
            id: id,
            name: name,
            imageURL: imageURL,
            isAdultContent: isAdultContent,
            genres: genres,
            overview: overview,
            release_date: release_date,
            score: score,
            isFavorite: false
        )
    }
}
