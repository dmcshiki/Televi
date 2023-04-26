//
//  MovieInformationViewController.swift
//  Televi
//
//  Created by Daniel McCarthy on 08/02/23.
//

import UIKit
import RxSwift
import Swinject


enum MovieInformationViewState {
    case success(MovieInformation)
    case error
    case loading
}

protocol MovieInformationViewProtocol: AnyObject, Storyboarded {
    func updateScreen(to state: MovieInformationViewState)
}

class MovieInformationViewController: UIViewController, Storyboarded {
    var movieId: Int?
    private var movieInformationPresenter: MovieInformationPresenter!
    private let loadingView = LoadingView()
    var coordinator: Coordinator?
    let disposeBag = DisposeBag()
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var tryAgain: UIButton!
    let container: Container = buildApplicationContainer()
    
    private var movieInformation: MovieInformation? {
        didSet {
            guard let movieInformation = movieInformation else { return }
            self.setupUI(movieInformation: movieInformation)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieInformationPresenter = container.resolve(MovieInformationPresenter.self)!
        view.addSubview(loadingView)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loadingView.topAnchor.constraint(equalTo: view.topAnchor),
            loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        tryAgain.rx.tap.subscribe(onNext: {
            self.movieInformationPresenter.fetchMovieInformation(movieId: self.movieId!)
        }).disposed(by: disposeBag)
        
        favoriteButton.rx.tap.subscribe(onNext: {
            self.toggleFavorite()
        }).disposed(by: disposeBag)
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
    @IBOutlet weak var favoriteButton: UIButton!
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
        if(movieInformation.isFavorite) {
            favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
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
    func updateScreen(to state: MovieInformationViewState) {
        switch state {
        case let .success(movieInformation):
            self.movieInformation = movieInformation
            errorView.isHidden = true
            loadingView.isHidden = true
        case .loading:
            errorView.isHidden = true
            loadingView.isHidden = false
        case .error:
            loadingView.isHidden = true
            errorView.isHidden = false
        }
    }
    
    func toggleFavorite() {
        self.movieInformationPresenter.toggleFavorite(movieId: self.movieId!)
        self.movieInformation!.isFavorite = !self.movieInformation!.isFavorite
        
        if(self.movieInformation!.isFavorite) {
            favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
}
