//
//  SearchView.swift
//  Movies
//
//  Created by Camila Storck on 16/03/2024.
//

import SwiftUI
import MoviesService

struct SearchView: View {
    let movies: [MovieModel]
    @Binding var searchValue: String
    let tapped: (MovieModel) -> Void
    
    var body: some View {
        ScrollView {
            ForEach(movies) { movie in
                SearchViewCell(movie: movie)
                    .onTapGesture {
                        tapped(movie)
                    }
            }
        }
        .padding(.vertical, 12)
    }
}

struct SearchViewCell: View {
    let movie: MovieModel
    @State private var addTapped: Bool = false
    
    private var subscribed: Bool {
        UsersDefaults.isMovieSaved(movie: movie)
    }
    
    var body: some View {
        VStack {
            HStack(spacing: 14) {
                Image(uiImage: movie.poster)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60)
                    .cornerRadius(4)
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(movie.title)
                        .font(Font.bold(size: 16))
                        .foregroundStyle(.title)
                    
                    Text(movie.year)
                        .textCase(.uppercase)
                        .font(Font.medium(size: 12))
                        .foregroundStyle(.title)
                }
                
                Spacer()
                
                Button(addTapped ? "SEARCH_ADDED_BUTTON".localized : "SEARCH_ADD_BUTTON".localized) {
                    addTapped.toggle()
                    
                    if subscribed {
                        UsersDefaults.deleteFavoriteMovie(movie: movie)
                    } else {
                        UsersDefaults.saveFavoriteMovie(movie: movie)
                    }
                }
                .padding(.vertical, 4)
                .padding(.horizontal, 10)
                .font(Font.medium(size: 12))
                .background(addTapped ? .gray : .clear)
                .foregroundStyle(addTapped ? .title : .gray)
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(.gray, lineWidth: 1)
                )
            }
            .padding(.vertical, 4)
            .padding(.horizontal)
            .frame(maxWidth: .infinity)
            
            Color.gray.opacity(0.5)
                .frame(height: 1)
                .frame(maxWidth: .infinity)
        }
        .onAppear {
            addTapped = subscribed
        }
    }
}
