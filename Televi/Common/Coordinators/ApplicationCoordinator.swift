//
//  ApplicationCoordinator.swift
//  m,
//
//  Created by Daniel McCarthy on 17/04/23.
//

import Foundation
import UIKit
import Swinject
import SwinjectAutoregistration

class ApplicationCoordinator {
    var children: [Coordinator] = []
    let window: UIWindow

    // Deixa anotado para não esquecer quando for mexer com Swinject:
     let container: Container = buildApplicationContainer()
    
    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        // Instanciar TabBarController
        let tabBarController = UITabBarController()

        // Colocar as UINavigationControllers dentro da TabBarController
        let moviesNavigationController = UINavigationController()
        moviesNavigationController.tabBarItem = UITabBarItem(title: ("movies"), image: UIImage(systemName: "video.circle"), selectedImage: nil)

        let favoriteMoviesNavigationController = UINavigationController()
        favoriteMoviesNavigationController.tabBarItem = UITabBarItem(title: ("favorites"), image: UIImage(systemName: "heart.fill"), selectedImage: nil)
        
        let firstCoordinator = container.resolve(MainCoordinator.self, argument: moviesNavigationController)!
        firstCoordinator.start()
        
        let secondCoordinator = container.resolve(FavoriteCoordinator.self, argument: favoriteMoviesNavigationController)!
        secondCoordinator.start()
        
        children.append(firstCoordinator)
        children.append(secondCoordinator)

        // Setar a NavController
        tabBarController.setViewControllers([moviesNavigationController, favoriteMoviesNavigationController], animated: false)

        // Adicionar a tabBar como root do app
        self.window.rootViewController = tabBarController
        self.window.makeKeyAndVisible()
    }
}
