//
//  MoviesPresenter.swift
//  Televi
//
//  Created by Daniel McCarthy on 26/02/23.
//

import Foundation
import RxSwift

protocol MoviesPresenterProtocol {
    func fetchMovies()
}

struct MoviesPresenter: MoviesPresenterProtocol {
    init(view: MoviesViewProtocol) {
        self.view = view
    }

    var televiRepository = TeleviRepository(televiRDS: TeleviRDS())
    weak var view: MoviesViewProtocol?
    let disposeBag = DisposeBag()
    
    func fetchMovies() {
        self.view?.updateScreen(to: .loading)
        return televiRepository.fetchMovies().subscribe(
            onSuccess: { movies in
                view?.updateScreen(to: .success(movies))
            }, onFailure: { _ in
                view?.updateScreen(to: .error)
            }
        ).disposed(by: disposeBag)
    }
}
