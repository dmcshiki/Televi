//
//  TeleviRDS.swift
//  Televi
//
//  Created by Daniel McCarthy on 16/02/23.
//

import Foundation
import Moya
import Combine

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
        return .get
    }
    
    var task: Moya.Task {
            return .requestPlain
        }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}

class TeleviRDS {
    let provider = MoyaProvider<TeleviAPI>();
    
    func getMovies(completion: @escaping ([MovieRM]?, Error?) -> Void) {
        provider.request(TeleviAPI.readMovies) { (result) in
            switch result {
                case .success(let response):
                guard let moviesResponse = try? JSONDecoder().decode([MovieRM].self, from: response.data)
                    else {
                        completion(nil, NSError(domain: "TeleviRDS", code: 0, userInfo: [NSLocalizedDescriptionKey: "Error decoding movies response"]))
                        return
                    }
                    completion(moviesResponse, nil)
                case .failure(let error):
                    completion(nil, error)
            }
        }
    }
}
    
