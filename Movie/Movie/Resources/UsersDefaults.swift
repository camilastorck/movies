//
//  UsersDefaults.swift
//  Movie
//
//  Created by Camila Storck on 22/03/2024.
//

import Foundation
import MoviesService

protocol UsersDefaultsProtocol {
    static func getFavoriteMovies() -> [MovieModel]
    static func saveFavoriteMovie(movie: MovieModel)
}

struct UsersDefaults: UsersDefaultsProtocol {
    
    static func getFavoriteMovies() -> [MovieModel] {
        guard let data = UserDefaults.standard.data(forKey: StorageKeys.favoriteMovies.rawValue),
              let favorites = try? JSONDecoder().decode([MovieModel].self, from: data) else {
            return []
        }
        return favorites
    }
    
    static func saveFavoriteMovie(movie: MovieModel) {
        var favoriteMovies = getFavoriteMovies()
        favoriteMovies.append(movie)
        
        guard let data = try? JSONEncoder().encode(favoriteMovies) else { return }
        UserDefaults.standard.set(data, forKey: StorageKeys.favoriteMovies.rawValue)
    }
    
    static func deleteFavoriteMovie(movie: MovieModel) {
        let favoriteMovies = getFavoriteMovies().filter { $0.id != movie.id }
        
        guard let data = try? JSONEncoder().encode(favoriteMovies) else { return }
        UserDefaults.standard.set(data, forKey: StorageKeys.favoriteMovies.rawValue)
    }
    
    static func isMovieSaved(movie: MovieModel) -> Bool {
        let favoriteMovies = getFavoriteMovies()
        return favoriteMovies.contains(where: { $0.id == movie.id })
    }
}

enum StorageKeys: String {
    case favoriteMovies = "FavoriteMovies"
}
