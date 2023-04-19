//
//  MainCoordinator.swift
//  Televi
//
//  Created by Daniel McCarthy on 01/03/23.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    deinit {
        print("self")
    }
    
    func start() {
        let vc = MoviesViewController.instantiate()
        navigationController.pushViewController(vc, animated: false)
        vc.coordinator = self
    }
    
    func navigatoToMovieInformation(movieId: Int) {
        let vc = MovieInformationViewController.instantiate()
        vc.coordinator = self
        vc.movieId = movieId
        navigationController.pushViewController(vc, animated: true)
    }
    
    func pop() {
        navigationController.popViewController(animated: true)
    }
    
    func stopChildren() {}
}
