//
//  MovieInformationViewController.swift
//  Televi
//
//  Created by Daniel McCarthy on 08/02/23.
//

import UIKit

class MovieInformationViewController: UIViewController {
    var movieId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(movieId!)
        enableIcons(movieInformation: movieInfo)
        scoreLabel.text = String(movieInfo.score)
        titleLabel.text = movieInfo.title
        releaseDateLabel.text = movieInfo.release_date
        genresLabel.text = movieInfo.genres.joined(separator: ", ")
        makeOverviewText(overviewLabel: atribbutedOverviewLabel, movieInformation: movieInfo)
    }
    
    
    func makeOverviewText (overviewLabel: UILabel, movieInformation: MovieInformation){
        let overviewTitleText = "Sinopse: "
        let overviewTitleAtributes = [NSAttributedString.Key.font: UIFont(name: "Helvetica Neue Bold", size: 18)]
        let overviewLabelTitleText = NSMutableAttributedString(string: overviewTitleText, attributes: overviewTitleAtributes as [NSAttributedString.Key : Any])
        
        let overviewDescriptionAtributes = [NSAttributedString.Key.font: UIFont(name: "Helvetica Neue", size: 18)]
        let overviewLabelDescriptionText = NSAttributedString(string: movieInformation.overview, attributes: overviewDescriptionAtributes as [NSAttributedString.Key : Any])
        
        overviewLabelTitleText.append(overviewLabelDescriptionText)
        
        overviewLabel.attributedText = overviewLabelTitleText
    }

    let movieInfo = MovieInformation(
        id: 1,
        title: "FIlmasso",
        image: "https://image.tmdb.org/t/p/w200/fycMZt242LVjagMByZOLUGbCvv3.png",
        isADultContent: true,
        genres: ["Comedia", "Acao", "Drama"],
        overview: "In the continuing saga of the Corleone crime family, a young Vito Corleone grows up in Sicily and in 1910s New York. In the 1950s, Michael Corleone attempts to expand the family business into Las Vegas, Hollywood and Cuba.",
        release_date: "1974-12-20",
        score: 8
    )
    
    func enableIcons(movieInformation: MovieInformation) {
        plusEighteenIcon.isHidden = !movieInformation.isADultContent
        
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


