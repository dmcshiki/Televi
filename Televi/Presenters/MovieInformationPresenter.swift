//
//  MoviesPresenter.swift
//  Televi
//
//  Created by Daniel McCarthy on 26/02/23.
//

import Foundation

protocol MovieInformationPresenterProtocol {
    func fetchMovieInformation(movieId: Int)
}

struct MovieInformationPresenter: MovieInformationPresenterProtocol {
    init(view: MovieInformationViewProtocol) {
        self.view = view
    }
    
    var televiRepository = TeleviRepository(televiRDS: TeleviRDS())
    weak var view: MovieInformationViewProtocol?

    func fetchMovieInformation(movieId: Int) {
        televiRepository.getMovieInformation(movieId: movieId) { (result) in
            switch result {
            case .success(let movieInformationResponse):
                self.view?.displayMovieInformation(movieInformation: movieInformationResponse)
            case .failure(let error):
                print(error)
            }
        }
    }
}
