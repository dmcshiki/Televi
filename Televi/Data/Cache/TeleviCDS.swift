//
//  TeleviCDS.swift
//  Televi
//
//  Created by Daniel McCarthy on 11/04/23.
//

import Foundation
import SwiftyUserDefaults
import RxSwift

protocol TeleviCDSProtocol {
    func upsertMovies(movies: [MovieCM]) -> Completable
    func getMovies() -> Single<[MovieCM]>
    func upsertMovieInformation(movieInformation: MovieInformationCM) -> Completable
    func getMovieInformation(movieId: Int) throws -> Single<MovieInformationCM>
    func toggleFavorite(movieId: Int) -> Completable
    func getFavoriteMovies() -> Single<[Int]>
    func isMovieFavorite(movieId: Int) -> Single<Bool>
}

struct Constants {
    static let moviesKey = DefaultsKey<[MovieCM]>("movies", defaultValue: [])
    static let movieInformationKey = DefaultsKey<[MovieInformationCM]>("movieInformation", defaultValue: [])
    static let favoriteMoviesKey = DefaultsKey<[Int]>("favoriteMovies", defaultValue: [])
}


class TeleviCDS: Codable, DefaultsSerializable {
    func upsertMovies(movies: [MovieCM]) -> Completable {
        Defaults[key: Constants.moviesKey] = movies
        return Completable.empty()
    }
    
    func getMovies() -> Single<[MovieCM]> {
        let movies = Defaults[key: Constants.moviesKey]
        guard !movies.isEmpty else {
            return Observable<[MovieCM]>.empty().asSingle()
        }
        return Single.just(movies)
    }
    
    func upsertMovieInformation(movieInformation: MovieInformationCM) -> Completable {
        Defaults[key: Constants.movieInformationKey].append(movieInformation)
        return Completable.empty()
    }
    
    func getMovieInformation(movieId: Int) throws -> Single<MovieInformationCM> {
        let movieInformation = Defaults[key: Constants.movieInformationKey]
        guard let movieInfo = movieInformation.first(where: { movieInformation in
            movieInformation.id == movieId
        }) else {
            throw NSError()
        }
        return Single.just(movieInfo)
    }
    
    func toggleFavorite(movieId: Int) -> Completable {
        if(Defaults[key: Constants.favoriteMoviesKey]).contains(movieId) {
            Defaults[key: Constants.favoriteMoviesKey].removeAll(where: { $0 == movieId })
        } else {
            Defaults[key: Constants.favoriteMoviesKey].append(movieId)
        }
        return Completable.empty()
    }
    
    func getFavoriteMovies() -> Single<[Int]> {
        return Single.just(Defaults[key: Constants.favoriteMoviesKey])
    }
    
    func isMovieFavorite(movieId: Int) -> Single<Bool> {
        return Single.just(
            Defaults[key: Constants.favoriteMoviesKey].contains(movieId)
        )
    }
}
