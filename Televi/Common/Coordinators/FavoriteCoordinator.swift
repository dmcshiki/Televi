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
    let container: Container = buildApplicationContainer()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    deinit {
        print("self")
    }
    
    func start() {
        let vc = container.resolve(FavoriteMoviesViewController.self)!
        navigationController.pushViewController(vc, animated: false)
        vc.coordinator = self
    }
    
    func navigatoToMovieInformation(movieId: Int) {
        let vc = container.resolve(MovieInformationViewController.self)!
        vc.coordinator = self
        vc.movieId = movieId
        navigationController.pushViewController(vc, animated: true)
    }
    
    func pop() {
        navigationController.popViewController(animated: true)
    }
    
    func stopChildren() {}
}
