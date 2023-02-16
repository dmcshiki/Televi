//
//  MoviesViewController.swift
//  Televi
//
//  Created by Daniel McCarthy on 08/02/23.
//

import UIKit

class MoviesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    var movies: [Movie] = []
    var moviesRM: [MovieRM] = []
    
    let movie = Movie(
        id: 1873842,
        name: "Filme foda",
        image: UIImage(named: "movieCatch")!
    )
    
    let movie2 = Movie(
        id: 7832134,
        name: "cafe com leite",
        image: UIImage(named: "movieCatch")!
    )
    
    let movie3 = Movie(
        id: 9348567,
        name: "Filme bao",
        image: UIImage(named: "movieCatch")!
    )
    
    
    let televiRDS = TeleviRDS();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for _ in 0 ... 6 {
            movies.append(movie)
        }
        movies.append(movie2)
        movies.append(movie3)
        televiRDS.getMovies { (movies, error) in
            if let error = error {
                throw error
            } else {
                self.moviesRM = movies ?? []
            }
        }
        print(moviesRM)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! MovieInformationViewController
        destVC.movieId = sender as? Int
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        
        if let movieCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as? MovieCollectionViewCell {
            
            movieCell.configure(with: movies[indexPath.row].name, and: movies[indexPath.row].image)
            
            cell = movieCell
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let id = movies[indexPath.row].id
        performSegue(withIdentifier: "toMovieInformationVC", sender: id)
    }
}

