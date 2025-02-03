//
//  Coordinator.swift
//  Movies
//
//  Created by Camila Storck on 18/03/2024.
//

import UIKit
import MoviesService

protocol Coordinator {
    var children: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    func start()
}

final class MoviesCoordinator: Coordinator {
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let service: ServiceProtocol = Service()
        let viewModel = HomeViewModel(service: service)
        let vc = HomeViewController(viewModel: viewModel)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func seeDetails(movie: MovieModel) {
        let viewModel = DetailsViewModel(movie: movie)
        let vc = DetailsViewController(viewModel: viewModel)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
}
