//
//  MovieInformationViewController.swift
//  Televi
//
//  Created by Daniel McCarthy on 08/02/23.
//

import UIKit
import Kingfisher

protocol MovieInformationViewProtocol: AnyObject {
    func displayMovieInformation(movieInformation: MovieInformation)
}

class MovieInformationViewController: UIViewController {
    var movieId: Int?
    private var movieInformationPresenter: MovieInformationPresenter!
    private let loadingView = LoadingView()
    private var movieInformation: MovieInformation? {
        didSet {
            guard let movieInformation = movieInformation else { return }
            self.setupUI(movieInformation: movieInformation)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieInformationPresenter = MovieInformationPresenter(view: self)
        
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
        movieInformationPresenter.fetchMovieInformation(movieId: self.movieId!)
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
    
    private func setupUI(movieInformation: MovieInformation) {
        showImage(movieInformation: movieInformation)
        enableIcons(movieInformation: movieInformation)
        scoreLabel.text = String(movieInformation.score)
        titleLabel.text = movieInformation.name
        releaseDateLabel.text = movieInformation.release_date
        genresLabel.text = movieInformation.genres.joined(separator: ", ")
        makeOverviewText(overviewLabel: atribbutedOverviewLabel, movieInformation: movieInformation)
    }
    
    private func showImage(movieInformation: MovieInformation) {
        let placeholder = UIImage(named: "movieCatch")
        
        guard let url = URL(string: self.movieInformation!.imageURL) else {
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

extension MovieInformationViewController: MovieInformationViewProtocol {
    func displayMovieInformation(movieInformation: MovieInformation) {
        self.movieInformation = movieInformation
        loadingView.isHidden = true
    }
}
