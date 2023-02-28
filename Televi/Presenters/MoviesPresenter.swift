//
//  MoviesPresenter.swift
//  Televi
//
//  Created by Daniel McCarthy on 26/02/23.
//

import Foundation

protocol MoviesPresenterProtocol {
    func fetchMovies()
}

struct MoviesPresenter: MoviesPresenterProtocol {
    init(view: MoviesViewProtocol) {
        self.view = view
    }
    
    var televiRepository = TeleviRepository(televiRDS: TeleviRDS())
    weak var view: MoviesViewProtocol?
    
    func fetchMovies() {
        televiRepository.getMovies { (result) in
            switch result {
            case .success(let moviesResponse):
                self.view?.displayMovies(movies: moviesResponse)
            case .failure(let error):
                print(error)
            }
        }
    }
}
