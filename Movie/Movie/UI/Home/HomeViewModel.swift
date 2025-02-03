//
//  HomeViewModel.swift
//  Movies
//
//  Created by Camila Storck on 18/03/2024.
//

import SwiftUI
import MoviesService

protocol HomeDelegate: AnyObject {
    func seeDetails(movie: MovieModel)
}

final class HomeViewModel: ObservableObject {
    
    private let service: ServiceProtocol
    weak var delegate: HomeDelegate?
    
    @Published var searchResults: [MovieModel] = []
    @Published var movies: [MovieModel] = []
    @Published var isLoading: Bool = true
    private var timer: Timer?
    
    init(service: ServiceProtocol) {
        self.service = service
    }
    
    func seeMovieDetails(movie: MovieModel) {
        delegate?.seeDetails(movie: movie)
    }
    
    func searchValue(query: String) {
        isLoading = true
        
        Task {
            let result = await service.searchMovie(query: query)
            
            Task { @MainActor in
                switch result {
                case .success(let result):
                    self.searchResults = result.movies
                    isLoading = false
                case .failure:
                    self.searchResults = []
                    isLoading = false
                }
            }
        }
    }
    
    func getMoviesList() async {
        let result = await service.getMovies(type: .upcoming)
        
        await MainActor.run {
            isLoading = false
            
            switch result {
            case .success(let result):
                self.movies = result.movies
            case .failure:
                self.movies = []
            }
        }
    }
    
    func debounce(interval: TimeInterval, action: @escaping (() -> Void)) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: false) { _ in
            action()
        }
    }
}
