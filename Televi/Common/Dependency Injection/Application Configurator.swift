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
    container.setupPresenters()

    return container
}

extension Container {
    func setupProvider() {
        autoregister(MoyaProvider<TeleviAPI>.self, initializer: MoyaProvider<TeleviAPI>.init).inObjectScope(.container)
    }
    
    func setupRDS() {
        register(TeleviRDS.self) { _ in
            TeleviRDS(provider: self.resolve(MoyaProvider<TeleviAPI>.self)!)
        }.inObjectScope(.container)
    }
    
    func setupCDS() {
        autoregister(TeleviCDS.self, initializer: TeleviCDS.init).inObjectScope(.container)
    }
    
    func setupRepository() {
        register(TeleviRepository.self) { _ in
            TeleviRepository(televiRDS: self.resolve(TeleviRDS.self)!, televiCDS: self.resolve(TeleviCDS.self)!)
        }.inObjectScope(.container)
    }
    
    //nao da pra criar init da view protocol
    func setupViewProtocol() {
        register(MoviesViewProtocol.self) { _ in
            MoviesViewController.instantiate()
        }.inObjectScope(.container)
    }
    
    func setupCoordinator() {
        register(MainCoordinator.self) { _, argument in
            MainCoordinator(navigationController: argument)
        }.inObjectScope(.container)
    }
    
    func setupPresenters() {
        register(MoviesPresenter.self) { _ in
            //nao da pra usar resolve no viewprotocol
            MoviesPresenter(view: self.resolve(MoviesViewProtocol.self)!, televiRepository: self.resolve(TeleviRepository.self)!)
        }.inObjectScope(.container)
        
        register(MovieInformationPresenter.self) { _ in
            MovieInformationPresenter(view: self.resolve(MovieInformationViewProtocol.self)!, televiRepository: self.resolve(TeleviRepository.self)!)
        }.inObjectScope(.container)
        
        register(FavoriteMoviesPresenter.self) { _ in
            FavoriteMoviesPresenter(view:self.resolve(FavoriteMoviesViewProtocol.self)!, televiRepository: self.resolve(TeleviRepository.self)!)
        }.inObjectScope(.container)
    }
}
