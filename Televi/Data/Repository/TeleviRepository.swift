//
//  TeleviRepository.swift
//  Televi
//
//  Created by Daniel McCarthy on 17/02/23.
//

import Foundation

struct TeleviRepository {
    let TeleviRDS: TeleviRDS
    
    func getMovies(completion: @escaping ((Result<[Movie], Error>)) -> Void) {
        TeleviRDS.getMovies(
            completion: { (moviesResponse, error) in
                if let error = error {
                    completion((.failure(error)))
                } else {
                    guard let movies = moviesResponse.map ({
                        $0.map({
                            $0.toDomainModel()
                        })
                    }) else {
                        completion(.failure(NSError(domain: "Failed mapping", code: 43)))
                        return
                    }
                    completion(.success(movies))
                }
            }
        )
    }
    
    func getMovieInformation(movieId: Int, completion: @escaping ((Result<MovieInformation, Error>)) -> Void) {
        TeleviRDS.getMovieInformation(movieId: movieId,
            completion: { (movieInformationResponse, error) in
                if let error = error {
                    completion(.failure(error))
                } else {
                    guard let movieInformation = movieInformationResponse.map({
                            $0.toDomainModel()
                        })
                    else {
                        completion(.failure(NSError(domain: "Failed mapping", code: 43)))
                        return
                    }
                    completion(.success(movieInformation))
                }
            }
        )
    }
}
