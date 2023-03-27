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
    
    var televiRepository = TeleviRepository(televiRDS: TeleviRDS())
    weak var view: MovieInformationViewProtocol?
    let disposeBag = DisposeBag()

    func fetchMovieInformation(movieId: Int) {
        self.view?.updateScreen(from: .loading)
        return televiRepository.getMovieInformation(movieId: movieId).subscribe(
            onSuccess: { movie in
                self.view?.updateScreen(from: .error)
            }, onFailure: { _ in
                self.view?.updateScreen(from: .error)
            }
        ).disposed(by: disposeBag)
    }
}
