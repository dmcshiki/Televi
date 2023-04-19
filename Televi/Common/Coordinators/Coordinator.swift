//
//  Coordinator.swift
//  Televi
//
//  Created by Daniel McCarthy on 01/03/23.
//

import Foundation
import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] {get set}
    var navigationController: UINavigationController {get set}
    
    func start()
    
    func pop()
    
    func stopChildren()
    
    func navigatoToMovieInformation(movieId: Int)
}
