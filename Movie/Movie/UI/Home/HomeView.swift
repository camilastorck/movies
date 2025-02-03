//
//  HomeView.swift
//  Movies
//
//  Created by Camila Storck on 13/03/2024.
//

import SwiftUI
import MoviesService

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    @State private var searchValue: String = ""
    @State private var isSearching: Bool = false
    
    var body: some View {
        VStack(spacing: -16) {
            SearchBarView(searchValue: $searchValue, isSearching: $isSearching)
                .onChange(of: searchValue) { _, value in
                    viewModel.debounce(interval: 2) {
                        viewModel.searchValue(query: value)
                    }
                }
            
            if viewModel.isLoading {
                LoadingIndicator()
            } else {
                mainView
            }
        }
        .background(Colors.background.color)
    }
    
    var mainView: some View {
        VStack {
            if isSearching {
                SearchView(movies: viewModel.searchResults, searchValue: $searchValue) { movie in
                    viewModel.seeMovieDetails(movie: movie)
                }
            } else {
                MoviesView(viewModel: viewModel)
            }
        }
    }
}

struct MoviesView: View {
    let viewModel: HomeViewModel
    @State private var favoriteMovies: [MovieModel] = []
    
    var body: some View {
        VStack(spacing: -16) {
            if !favoriteMovies.isEmpty {
                SubscriptionsView(movies: favoriteMovies) { movie in
                    viewModel.seeMovieDetails(movie: movie)
                }
            }
            ListView(movies: viewModel.movies) { movie in
                viewModel.seeMovieDetails(movie: movie)
            }
            .onAppear {
                favoriteMovies = UsersDefaults.getFavoriteMovies()
            }
        }
    }
}
