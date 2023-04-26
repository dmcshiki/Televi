//
//  Application Configurator.swift
//  Televi
//
//  Created by Daniel McCarthy on 24/04/23.
//

import Swinject
import SwinjectAutoregistration
import UIKit
import RxSwift
import Moya

let container = Container()

func buildApplicationContainer() -> Container {
    container.setupProvider()
    container.setupCDS()
    container.setupRDS()
    container.setupRepository()
    container.setupViewControl()
    container.setupViewProtocol()
    container.setupCoordinator()
    container.setupPresenters()
    
    return container
}

extension Container {
    func setupProvider() {
        register(MoyaProvider<TeleviAPI>.self) { _ in
            MoyaProvider<TeleviAPI>.init()
        }.inObjectScope(.container)
    }
    
    func setupRDS() {
        register(TeleviRDS.self) { _ in
            TeleviRDS(provider: self.resolve(MoyaProvider<TeleviAPI>.self)!)
        }.inObjectScope(.container)
    }
    
    func setupCDS() {
        register(TeleviCDS.self) { _ in
            TeleviCDS.init()
        }.inObjectScope(.container)
    }
    
    func setupRepository() {
        register(TeleviRepository.self) { _ in
            TeleviRepository(televiRDS: self.resolve(TeleviRDS.self)!, televiCDS: self.resolve(TeleviCDS.self)!)
        }.inObjectScope(.container)
    }
    
    func setupViewControl() {
        register(MoviesViewController.self) { _ in
            MoviesViewController.instantiate()
        }.inObjectScope(.container)
        
        register(MovieInformationViewController.self) { _ in
            MovieInformationViewController.instantiate()
        }.inObjectScope(.container)
        
        register(FavoriteMoviesViewController.self) { _ in
            FavoriteMoviesViewController.instantiate()
        }.inObjectScope(.container)
    }
    
    func setupViewProtocol() {
        register(MoviesViewProtocol.self) { _ in
            MoviesViewController.instantiate()
        }.inObjectScope(.container)
        
        register(MovieInformationViewProtocol.self) { _ in
            MovieInformationViewController.instantiate()
        }.inObjectScope(.container)
        
        register(FavoriteMoviesViewProtocol.self) { _ in
            FavoriteMoviesViewController.instantiate()
        }.inObjectScope(.container)
    }
    
    func setupCoordinator() {
        register(MainCoordinator.self) { _, navController in
            MainCoordinator(navigationController: navController)
        }.inObjectScope(.container)
        
        register(FavoriteCoordinator.self) { _, navController in
            FavoriteCoordinator(navigationController: navController)
        }.inObjectScope(.container)
    }
    
    func setupPresenters() {
        register(MoviesPresenter.self) { _ in
            MoviesPresenter(televiRepository: self.resolve(TeleviRepository.self)!)
        }.initCompleted { resolver, presenter in
            presenter.view = resolver.resolve(MoviesViewProtocol.self)
        }.inObjectScope(.container)
        
        register(MovieInformationPresenter.self) { _ in
            MovieInformationPresenter(view: self.resolve(MovieInformationViewProtocol.self)!, televiRepository: self.resolve(TeleviRepository.self)!)
        }.inObjectScope(.container)
        
        register(FavoriteMoviesPresenter.self) { _ in
            FavoriteMoviesPresenter(view:self.resolve(FavoriteMoviesViewProtocol.self)!, televiRepository: self.resolve(TeleviRepository.self)!)
        }.inObjectScope(.container)
    }
}
