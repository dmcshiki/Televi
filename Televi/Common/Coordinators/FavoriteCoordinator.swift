//
//  FavoriteCoordinator.swift
//  Televi
//
//  Created by Daniel McCarthy on 17/04/23.
//

import Foundation
import UIKit
import SwinjectAutoregistration
import Swinject

class FavoriteCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    deinit {
        print("self")
    }
    
    func start() {
        let vc = FavoriteMoviesViewController.instantiate()
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
