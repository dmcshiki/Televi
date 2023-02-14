//
//  MovieCollectionViewCell.swift
//  Televi
//
//  Created by Daniel McCarthy on 10/02/23.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    
    func configure(with movieName: String, and movieImage: UIImage) {
        movieNameLabel.text = movieName
        movieImageView.image = movieImage
    }
}
