//
//  MoviesPresenter.swift
//  Televi
//
//  Created by Daniel McCarthy on 26/02/23.
//

import Foundation
import RxSwift
import Swinject

protocol MoviesPresenterProtocol {
    func fetchMovies()
}

class MoviesPresenter: MoviesPresenterProtocol {
    init(televiRepository: TeleviRepository) {
        self.televiRepository = televiRepository
    }
    
    private let televiRepository: TeleviRepository
    weak var view: MoviesViewProtocol?
    private let disposeBag = DisposeBag()
    
    func fetchMovies() {
        self.view?.updateScreen(to: .loading)
        return televiRepository.fetchMovies().subscribe(
            onSuccess: { movies in
                self.view?.updateScreen(to: .success(movies))
            }, onFailure: { _ in
                self.view?.updateScreen(to: .error)
            }
        ).disposed(by: disposeBag)
    }
}
