//
//  DetailsViewModel.swift
//  Movie
//
//  Created by Camila Storck on 20/03/2024.
//

import SwiftUI
import MoviesService

protocol DetailsDelegate: AnyObject {
    func dismiss()
}

final class DetailsViewModel: ObservableObject {
    @Published var movie: MovieModel
    weak var delegate: DetailsDelegate?
    
    init(movie: MovieModel) {
        self.movie = movie
    }
    
    var isMovieSubscribed: Bool {
        UsersDefaults.isMovieSaved(movie: movie)
    }
    
    func dismiss() {
        delegate?.dismiss()
    }
}
