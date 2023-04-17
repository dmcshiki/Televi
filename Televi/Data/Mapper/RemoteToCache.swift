//
//  RemoteToCache.swift
//  Televi
//
//  Created by Daniel McCarthy on 12/04/23.
//

import Foundation

extension MovieRM {
    func toCM() -> MovieCM {
        return MovieCM(
            id: id,
            name: name,
            imageUrl: imageURL
        )
    }
}

extension MovieInformationRM {
    func toCM() -> MovieInformationCM {
        return MovieInformationCM(
            id: id,
            name: name,
            imageUrl: imageURL,
            isAdultContent: isAdultContent,
            genres: genres,
            overview: overview,
            release_date: release_date,
            score: score
        )
    }
}
