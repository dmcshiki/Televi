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
    container.setupCDS()
    container.setupRDS()
    container.setupRepository()
    
    return container
}

extension Container {
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
}
