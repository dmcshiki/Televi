//
//  FavoriteMoviesPresenter.swift
//  Televi
//
//  Created by Daniel McCarthy on 17/04/23.
//

import Foundation
import RxSwift

protocol FavoriteMoviesPresenterProtocol {
    func fetchFavoriteMovies()
}

struct FavoriteMoviesPresenter: FavoriteMoviesPresenterProtocol {
    init(view: FavoriteMoviesViewProtocol) {
        self.view = view
    }

    var televiRepository = TeleviRepository(televiRDS: TeleviRDS(), televiCDS: TeleviCDS())
    weak var view: FavoriteMoviesViewProtocol?
    let disposeBag = DisposeBag()
    
    func fetchFavoriteMovies() {
        self.view?.updateScreen(to: .loading)
        return televiRepository.fetchFavoriteMovies().subscribe(
            onSuccess: { movies in
                view?.updateScreen(to: .success(movies))
            }, onFailure: { _ in
                view?.updateScreen(to: .error)
            }
        ).disposed(by: disposeBag)
    }
}
