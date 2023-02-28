//
//  MovieCollectionViewCell.swift
//  Televi
//
//  Created by Daniel McCarthy on 10/02/23.
//

import UIKit
import Kingfisher

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with movie: Movie) {
        movieNameLabel.text = movie.name
        let placeholder = UIImage(named: "movieCatch")
        guard let url = URL(string: movie.image) else {
            movieImageView.image = placeholder
            return
        }
        movieImageView.kf.setImage(with: url, placeholder: placeholder)
    }
}
