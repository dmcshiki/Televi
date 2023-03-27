//
//  TeleviRepository.swift
//  Televi
//
//  Created by Daniel McCarthy on 17/02/23.
//

import Foundation
import RxSwift

struct TeleviRepository {
    let televiRDS: TeleviRDS
    
    func fetchMovies() -> Single<[Movie]> {
        return televiRDS.fetchMovies().map({
            $0.map({
                $0.toDomainModel()
            })
        })
    }
    
    func fetchMovieInformation(movieId: Int) -> Single<MovieInformation> {
        return televiRDS.fetchMovieInformation(movieId: movieId).map({
            $0.toDomainModel()
        })
    }
}
