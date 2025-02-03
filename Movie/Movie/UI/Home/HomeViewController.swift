//
//  HomeViewController.swift
//  Movies
//
//  Created by Camila Storck on 20/03/2024.
//

import SwiftUI
import MoviesService

final class HomeViewController: UIHostingController<HomeView> {
    
    private let _view: HomeView
    private let viewModel: HomeViewModel
    weak var coordinator: MoviesCoordinator?
    
    init(viewModel: HomeViewModel) {
        _view = HomeView(viewModel: viewModel)
        self.viewModel = viewModel
        super.init(rootView: _view)
        viewModel.delegate = self
    }
    
    @MainActor
    required dynamic init?(coder aDecoder: NSCoder) { nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        fetchMoviesList()
    }
    
    private func fetchMoviesList() {
        Task {
            await viewModel.getMoviesList()
        }
    }
    
}

extension HomeViewController: HomeDelegate {
    
    func seeDetails(movie: MovieModel) {
        coordinator?.seeDetails(movie: movie)
    }
}
