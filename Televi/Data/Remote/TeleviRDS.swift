//
//  TeleviRDS.swift
//  Televi
//
//  Created by Daniel McCarthy on 16/02/23.
//

import Foundation
import Moya
import RxSwift
import RxCocoa

protocol TeleviRDSProtocol {
    func fetchMovies() -> Single<[MovieRM]>
    func fetchMovieInformation(movieId: Int) -> Single<MovieInformationRM>
}

enum TeleviAPI {
    case readMovies
    case readMovieInformation(id: Int)
}

extension TeleviAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://desafio-mobile.nyc3.digitaloceanspaces.com")!
    }
    
    var path: String {
        switch self {
        case TeleviAPI.readMovies:
            return "/movies"
        case TeleviAPI.readMovieInformation(let id):
            return "/movies/\(id)"
        }
    }
    
    var method: Moya.Method {
        .get
    }
    
    var task: Moya.Task {
        .requestPlain
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}

class TeleviRDS {
    init(provider: MoyaProvider<TeleviAPI>) {
        self.provider = provider
    }
    let provider: MoyaProvider<TeleviAPI>
    
    func fetchMovies() -> Single<[MovieRM]> {
        return provider.rx.request(.readMovies).map { response in
            guard let movies = try? JSONDecoder().decode([MovieRM].self, from: response.data)
            else {
                throw NSError()
            }
            return movies
        }
    }
    
    func fetchMovieInformation(movieId: Int) -> Single<MovieInformationRM> {
        return provider.rx.request(.readMovieInformation(id: movieId)).map { response in
            guard let movieInfo = try? JSONDecoder().decode(MovieInformationRM.self, from: response.data)
            else {
                throw NSError()
            }
            return movieInfo
        }
    }
}

