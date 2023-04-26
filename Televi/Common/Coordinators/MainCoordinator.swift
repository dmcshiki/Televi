//
//  MainCoordinator.swift
//  Televi
//
//  Created by Daniel McCarthy on 01/03/23.
//

import Foundation
import UIKit
import Swinject

class MainCoordinator: Coordinator {
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
        let vc = container.resolve(MoviesViewController.self)!
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
