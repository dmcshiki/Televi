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
    
    func getMovies() -> Single<[Movie]> {
        return televiRDS.getMovies().map({
            $0.map({
                $0.toDomainModel()
            })
        })
    }
    
    func getMovieInformation(movieId: Int) -> Single<MovieInformation> {
        return televiRDS.getMovieInformation(movieId: movieId).map({
            $0.toDomainModel()
        })
    }
}
