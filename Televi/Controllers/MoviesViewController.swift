//
//  MoviesViewController.swift
//  Televi
//
//  Created by Daniel McCarthy on 08/02/23.
//

import UIKit

enum MovieViewState {
    case success([Movie])
    case error
    case loading
}

protocol MoviesViewProtocol: AnyObject {
    func updateScreen(from state: MovieViewState)
}

class MoviesViewController: UIViewController, Storyboarded {
    private var movies: [Movie] = []
    private var moviesPresenter: MoviesPresenter!
    private let loadingView = LoadingView()
    var coordinator: MainCoordinator?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var tryAgain: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        moviesPresenter = MoviesPresenter(view: self)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "myCell")
        
        view.addSubview(loadingView)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loadingView.topAnchor.constraint(equalTo: view.topAnchor),
            loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        loadingView.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        moviesPresenter.fetchMovies()
    }
}

extension MoviesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as? MovieCollectionViewCell else {
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

extension MoviesViewController: MoviesViewProtocol {
    func updateScreen(from state: MovieViewState) {
        switch state {
        case let .success(movies):
            self.movies = movies
            self.collectionView.reloadData()
            self.errorView.isHidden = true
            loadingView.isHidden = true
        case .loading:
            loadingView.isHidden = false
        case .error:
            self.errorView.isHidden = false
        }
    }
}

