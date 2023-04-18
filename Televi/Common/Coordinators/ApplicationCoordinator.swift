//
//  ApplicationCoordinator.swift
//  Televi
//
//  Created by Daniel McCarthy on 17/04/23.
//

import Foundation
import UIKit

class ApplicationCoordinator {
    var children: [Coordinator] = []
    let window: UIWindow

    // Deixa anotado para não esquecer quando for mexer com Swinject:
    // let container: Container = buildApplicationContainer()
    
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
        moviesNavigationController.tabBarItem = UITabBarItem(title: ("favorites"), image: UIImage(systemName: "heart.fill"), selectedImage: nil)
        
       // Instanciar o seu Coordinator (Provavelmente MovieCoordinator)
       // Adicionar MovieCoordinator na lista de filhos
        let firstCoordinator = MainCoordinator(navigationController: moviesNavigationController)
        firstCoordinator.start()
        
        let secondCoordinator = FavoriteCoordinator(navigationController: favoriteMoviesNavigationController)
        
        children.append(firstCoordinator)
        children.append(secondCoordinator)

        // Setar a NavController
        tabBarController.setViewControllers([moviesNavigationController], animated: false)

        // Adicionar a tabBar como root do app
        self.window.rootViewController = tabBarController
        self.window.makeKeyAndVisible()
    }
}
