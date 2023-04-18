//
//  FavoriteMoviesViewController.swift
//  Televi
//
//  Created by Daniel McCarthy on 09/02/23.
//

import UIKit
import RxSwift

enum FavoriteMovieViewState {
    case success([Movie])
    case error
    case loading
}

protocol FavoriteMoviesViewProtocol: AnyObject, Storyboarded {
    func updateScreen(to state: FavoriteMovieViewState)
}

class FavoriteMoviesViewController: UIViewController {

    private var movies: [Movie] = []
    private var favoriteMoviesPresenter: FavoriteMoviesPresenter!
    private let loadingView = LoadingView()
    var coordinator: Coordinator?
    let disposeBag = DisposeBag()

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var tryAgain: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteMoviesPresenter = FavoriteMoviesPresenter(view: self)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(FavoriteMovieCollectionViewCell.self, forCellWithReuseIdentifier: "myCell")
        
        view.addSubview(loadingView)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loadingView.topAnchor.constraint(equalTo: view.topAnchor),
            loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        tryAgain.rx.tap.subscribe(onNext: {
                self.favoriteMoviesPresenter.fetchFavoriteMovies()
            }).disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        errorView.isHidden = true
        favoriteMoviesPresenter.fetchFavoriteMovies()
    }

}

extension FavoriteMoviesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteMovieCell", for: indexPath) as? FavoriteMovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(with: movies[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let id = movies[indexPath.row].id
        coordinator?.navigatoToMovieInformation(movieId: id)
    }
}

extension FavoriteMoviesViewController: FavoriteMoviesViewProtocol {
    func updateScreen(to state: FavoriteMovieViewState) {
        switch state {
        case let .success(movies):
            self.movies = movies
            self.collectionView.reloadData()
            loadingView.isHidden = true
            errorView.isHidden = true
        case .loading:
            loadingView.isHidden = false
        case .error:
            loadingView.isHidden = true
            errorView.isHidden = false
        }
    }
}

