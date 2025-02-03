//
//  Movies.swift
//
//  Created by Camila Storck on 22/03/2024.
//

import Foundation

public struct MoviesResponse: Codable {
    public let page: Int
    public let results: [Movie]
    public let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

public struct Movie: Codable, Identifiable {
    public let id: Int
    public let backdropPath: String?
    public let genreIDS: [Int]
    public let overview: String
    public let posterPath: String?
    public let releaseDate, title: String

    enum CodingKeys: String, CodingKey {
        case id
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
    }
}

public enum MovieType: String {
    case nowPlaying = "now_playing"
    case topRated = "top_rated"
    case popular
    case upcoming
}
