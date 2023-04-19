//
//  FavoriteCollectionViewCell.swift
//  Televi
//
//  Created by Daniel McCarthy on 17/04/23.
//

import Foundation
import Kingfisher

class FavoriteMovieCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var favoriteImageView: UIImageView!
    @IBOutlet weak var favoriteMovieNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with movie: Movie) {
        favoriteMovieNameLabel.text = movie.name
        let placeholder = UIImage(named: "movieCatch")
        guard let url = URL(string: movie.image) else {
            favoriteImageView.image = placeholder
            return
        }
        favoriteImageView.kf.setImage(with: url, placeholder: placeholder)
    }
}
