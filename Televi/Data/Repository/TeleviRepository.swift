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
    let televiCDS: TeleviCDS
    
    func fetchMovies() -> Single<[Movie]> {
        return televiRDS.fetchMovies().map { movies -> [MovieCM] in
            movies.map({$0.toCM()})
        }.flatMap { movies in
            return televiCDS.upsertMovies(movies: movies)
                .andThen(Single.just(movies.map({
                    $0.toDM()
                    })
                )
            )
        }.catch { _ in
            return televiCDS.getMovies().map { movies in
                movies.map({
                    $0.toDM()
                })
            }
        }
    }
    
    func fetchMovieInformation(movieId: Int) -> Single<MovieInformation> {
        return Single.zip(
            televiRDS.fetchMovieInformation(movieId: movieId).map { movieInformation in
                movieInformation.toCM()
            }.flatMap { moviesInformation in
                return televiCDS.upsertMovieInformation(movieInformation: moviesInformation).andThen(Single.just(moviesInformation))
            },
            televiCDS.isMovieFavorite(movieId: movieId),
            resultSelector: { movieInformation, isFavorite in
                return movieInformation.toDM(isFavorite: isFavorite)
            }
        )
    }
    
    func toggleFavoriteMovie(movieId: Int) -> Completable {
        return televiCDS.toggleFavorite(movieId: movieId)
    }
     
    func fetchFavoriteMovies() -> Single<[Movie]> {
        return Single.zip(
            televiCDS.getMovies(),
            televiCDS.getFavoriteMovies(),
            resultSelector: { movies, favorites in
                movies.filter { movie in favorites.contains(movie.id) }
                    .map { movie in movie.toDM() }
            }
        )
    }
}
