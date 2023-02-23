//
//  MoviesViewController.swift
//  Televi
//
//  Created by Daniel McCarthy on 08/02/23.
//

import UIKit

class MoviesViewController: UIViewController {
    var movies: [Movie] = []
    var televiRepository: TeleviRepository! = TeleviRepository(TeleviRDS: TeleviRDS())
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "myCell")
        televiRepository.getMovies { [weak self] (result) in
            switch result {
            case .success(let movies):
                self?.movies = movies
                self?.collectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension MoviesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! MovieInformationViewController
        destVC.movieId = sender as? Int ?? 0
    }
    
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
        performSegue(withIdentifier: "toMovieInformationVC", sender: id)
    }
}
