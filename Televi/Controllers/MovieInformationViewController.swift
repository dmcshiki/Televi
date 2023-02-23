//
//  MovieInformationViewController.swift
//  Televi
//
//  Created by Daniel McCarthy on 08/02/23.
//

import UIKit
import Kingfisher

class MovieInformationViewController: UIViewController {
    var movieId: Int?
    var televiRepository: TeleviRepository! = TeleviRepository(TeleviRDS: TeleviRDS())
    var movie: MovieInformation? {
        didSet {
            guard let movie = movie else { return }
            self.setupUI(movie: movie)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        televiRepository.getMovieInformation(movieId: movieId!) { [weak self] (result) in
            switch (result) {
            case .failure(let error):
                print(error)
            case .success(let movie):
                self?.movie = movie
            }
        }
    }
    
    @IBOutlet weak var atribbutedOverviewLabel: UILabel!
    
    @IBOutlet weak var fifthStarIcon: UIImageView!
    @IBOutlet weak var fourthStarIcon: UIImageView!
    @IBOutlet weak var thirdStarIcon: UIImageView!
    @IBOutlet weak var secondStarIcon: UIImageView!
    @IBOutlet weak var firstStarIcon: UIImageView!
    
    @IBOutlet weak var plusEighteenIcon: UIImageView!
    
    @IBOutlet weak var movieImageLabel: UIImageView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
}

extension MovieInformationViewController {
    
    private func setupUI(movie: MovieInformation) {
        showImage(movieInformation: movie)
        enableIcons(movieInformation: movie)
        scoreLabel.text = String(movie.score)
        titleLabel.text = movie.name
        releaseDateLabel.text = movie.release_date
        genresLabel.text = movie.genres.joined(separator: ", ")
        makeOverviewText(overviewLabel: atribbutedOverviewLabel, movieInformation: movie)
    }
    
    private func showImage(movieInformation: MovieInformation) {
        let placeholder = UIImage(named: "movieCatch")
        
        guard let url = URL(string: self.movie!.imageURL) else {
            movieImageLabel.image = placeholder
            return
        }
        
        movieImageLabel.kf.setImage(with: url, placeholder: placeholder)
    }
    
    private func enableIcons(movieInformation: MovieInformation) {
        plusEighteenIcon.isHidden = !movieInformation.isAdultContent
        
        if(movieInformation.score < 10) {
            fifthStarIcon.isHidden = true
        }
        if(movieInformation.score < 8) {
            fourthStarIcon.isHidden = true
        }
        if(movieInformation.score < 6) {
            thirdStarIcon.isHidden = true
        }
        if(movieInformation.score < 4) {
            secondStarIcon.isHidden = true
        }
        if(movieInformation.score < 2) {
            firstStarIcon.isHidden = true
        }
    }
    
    private func makeOverviewText (overviewLabel: UILabel, movieInformation: MovieInformation){
        let overviewTitleText = "Sinopse: "
        let overviewTitleAtributes = [NSAttributedString.Key.font: UIFont(name: "Helvetica Neue Bold", size: 18)]
        let overviewLabelTitleText = NSMutableAttributedString(string: overviewTitleText, attributes: overviewTitleAtributes as [NSAttributedString.Key : Any])
        
        let overviewDescriptionAtributes = [NSAttributedString.Key.font: UIFont(name: "Helvetica Neue", size: 18)]
        let overviewLabelDescriptionText = NSAttributedString(string: movieInformation.overview, attributes: overviewDescriptionAtributes as [NSAttributedString.Key : Any])
        
        overviewLabelTitleText.append(overviewLabelDescriptionText)
        
        overviewLabel.attributedText = overviewLabelTitleText
    }
}

