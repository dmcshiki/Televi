//
//  MoviesPresenter.swift
//  Televi
//
//  Created by Daniel McCarthy on 26/02/23.
//

import Foundation
import RxSwift

protocol MovieInformationPresenterProtocol {
    func fetchMovieInformation(movieId: Int)
}

struct MovieInformationPresenter: MovieInformationPresenterProtocol {
    init(view: MovieInformationViewProtocol) {
        self.view = view
    }
    
    var televiRepository = TeleviRepository(televiRDS: TeleviRDS(), televiCDS: TeleviCDS())
    weak var view: MovieInformationViewProtocol?
    let disposeBag = DisposeBag()

    func fetchMovieInformation(movieId: Int) {
        self.view?.updateScreen(to: .loading)
        return televiRepository.fetchMovieInformation(movieId: movieId).subscribe(
            onSuccess: { movie in
                view?.updateScreen(to: .success(movie))
            }, onFailure: { _ in
                view?.updateScreen(to: .error)
            }
        ).disposed(by: disposeBag)
    }
}
