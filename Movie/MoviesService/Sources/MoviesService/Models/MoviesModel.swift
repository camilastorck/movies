//
//  MoviesModel.swift
//
//  Created by Camila Storck on 25/03/2024.
//

import UIKit

public final class MovieModel: Identifiable, Codable {
    public let id: Int
    public let title: String
    public let overview: String
    public let genre: String
    public let year: String
    public let poster: UIImage
    public let backdropImage: UIImage
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case genre
        case year
        case poster
        case backdropImage
    }
    
    public init(
        id: Int,
        title: String,
        overview: String,
        genre: String,
        year: String,
        poster: UIImage,
        backdropImage: UIImage) {
            self.id = id
            self.title = title
            self.overview = overview
            self.genre = genre
            self.year = year
            self.poster = poster
            self.backdropImage = backdropImage
        }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        overview = try container.decode(String.self, forKey: .overview)
        genre = try container.decode(String.self, forKey: .genre)
        year = try container.decode(String.self, forKey: .year)
        
        let posterData = try container.decode(Data.self, forKey: .poster)
        let backdropImageData = try container.decode(Data.self, forKey: .backdropImage)
        
        poster = UIImage(data: posterData) ?? UIImage()
        backdropImage = UIImage(data: backdropImageData) ?? UIImage()
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(overview, forKey: .overview)
        try container.encode(genre, forKey: .genre)
        try container.encode(year, forKey: .year)
        try container.encode(poster.pngData(), forKey: .poster)
        try container.encode(backdropImage.pngData(), forKey: .backdropImage)
    }
    
    static func build(movie: Movie, genres: [Genre]) -> MovieModel {
        /// Genres
        let genre = genres.filter { genre in
            movie.genreIDS.contains(genre.id)
        }.first?.name ?? ""
        
        /// Date
        let year = movie.releaseDate.prefix(4)
        
        /// Images
        let posterURL = URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath ?? "")")
        let backdropURL = URL(string: "https://image.tmdb.org/t/p/w500\(movie.backdropPath ?? "")")
        
        return MovieModel(
            id: movie.id,
            title: movie.title,
            overview: movie.overview,
            genre: genre,
            year: String(year),
            poster: getImage(url: posterURL),
            backdropImage: getImage(url: backdropURL)
        )
    }
    
    static func getImage(url: URL?) -> UIImage {
        guard let url, let data = try? Data(contentsOf: url), let image = UIImage(data: data) else {
            return UIImage()
        }
        return image
    }
}

public final class MoviesResponseModel: Codable {
    public var page: Int
    public var totalPages: Int
    public var movies: [MovieModel]
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalPages
        case movies
    }
    
    public init(page: Int, totalPages: Int, movies: [MovieModel]) {
        self.page = page
        self.totalPages = totalPages
        self.movies = movies
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        page = try container.decode(Int.self, forKey: .page)
        totalPages = try container.decode(Int.self, forKey: .totalPages)
        movies = try container.decode([MovieModel].self, forKey: .movies)
    }
    
    static func build(movies: MoviesResponse, genres: [Genre]) -> MoviesResponseModel {
        MoviesResponseModel(
            page: movies.page,
            totalPages: movies.totalPages,
            movies: movies.results.map { movie in
                MovieModel.build(movie: movie, genres: genres)
            }
        )
    }
}
